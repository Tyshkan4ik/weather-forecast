//
//  MenuViewController.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 15.11.2022.
//

import UIKit
import Foundation

protocol MenuViewControllerDelegate: AnyObject {
    func deleteCityFromFavorite(id: FavoritesCellModel?)
    func changeCoordinateCity(coordinate: CoordinatesCellModel?)
}

class MenuViewController: UIViewController {
    
    weak var delegate: MenuViewControllerDelegate?
    
    //private let favoritesCity: Array<String>
    
    var coordinatesCellModel: [CityModel?] //CoordinatesCellModel]
    var favoritesCellModel: [FavoritesCellModel] = []
    
    private let service = FetchWeatherNetwork()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.8398272395, green: 0.9403695464, blue: 0.9815813899, alpha: 1)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

//    init(favoritesCity: Array<String>) {
//        self.favoritesCity = favoritesCity
//        super.init(nibName: nil, bundle: nil)
//    }
    
    init(coordinatesCityModel: Array<CityModel?>) {  // CoordinatesCellModel
        self.coordinatesCellModel = coordinatesCityModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8398272395, green: 0.9403695464, blue: 0.9815813899, alpha: 1)
        addNewElement()
        addConstraintsOnView()
        setupTable()

        let group = DispatchGroup()
        coordinatesCellModel.forEach {
            group.enter()
            self.fetchWeather(lon: "\($0?.lon ?? 0)" , lat: "\($0?.lat ?? 0)") {
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    private func addNewElement() {
        view.addSubview(tableView)
    }
    
    private func addConstraintsOnView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    
    private func fetchWeather(lon: String, lat: String, completion: @escaping () -> Void) {
        service.fetchCurrentWeather(for: CoordinateWeatherSource(lat: lat, lon: lon)) { [weak self] result in
            switch result {
            case let .success(model):
                let favoriteCity = FavoritesCellModel(cityName: model.name, temperature: model.main.temp, description: model.weather.first?.description ?? "", lat: "\(model.coord.lat)", lon: "\(model.coord.lon)", id: model.id)
                print(favoriteCity.lat)
                self?.favoritesCellModel.append(favoriteCity)
                completion()
            case let.failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension MenuViewController {
    func setupTable() {
    tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.identifier)
    }
}

extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesCellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.identifier, for: indexPath) as? FavoritesCell else {
            return UITableViewCell()
        }
        let model = favoritesCellModel[indexPath.row]
        print(model)
        
        
        cell.setup(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coordinate = CoordinatesCellModel(lat: favoritesCellModel[indexPath.row].lat, lon: favoritesCellModel[indexPath.row].lon, id: favoritesCellModel[indexPath.row].id)
        print(coordinate)
        delegate?.changeCoordinateCity(coordinate: coordinate)
    }
}

extension MenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, _ in
            self?.delegate?.deleteCityFromFavorite(id: self?.favoritesCellModel[indexPath.row])
            self?.favoritesCellModel.remove(at: indexPath.row)
            tableView.reloadData()
        }
        actionDelete.image = UIImage(systemName: "trash")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        actionDelete.backgroundColor = UIColor.init(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0)
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
    
}


