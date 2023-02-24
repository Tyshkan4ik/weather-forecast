//
//  SearchListOfCitiesController.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 12.12.2022.
//

import Foundation
import UIKit

protocol SearchListOfCitiesControllerDelegate: AnyObject {
    func changeCoordinatesOnMain(coordinates: CoordinatesFromSearchListModel?)
}

class SearchListOfCitiesController: UIViewController {
    
    weak var delegate: SearchListOfCitiesControllerDelegate?
    
    var searchListOfCities: [SearchListOfCitiesModel]? = []
    
    // тестируем
    private let service = FetchWeatherNetwork()
    
    let tableView: UITableView = {
       let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
//    init(searchList: Array<SearchListOfCitiesModel?>) {  // CoordinatesCellModel
//        self.searchListOfCities = searchList
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        return nil
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewElement()
        setupConstraint()
        setupTableView()
    }
    
    
    private func addNewElement() {
        view.addSubview(tableView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // тестируем
    private func fetchListCity(city: String) {
        service.fetchListOfCities(for: СitySearch(city: city)) { [weak self] result in
            switch result {
            case let .success(model):
                print("Феличита \(model)")
                for i in model {
                    self?.searchListOfCities?.append(SearchListOfCitiesModel(name: i.name, lat: i.lat, lon: i.lon, country: i.country, state: i.state ?? ""))
                    DispatchQueue.main.async{
                    self?.tableView.reloadData()
                    }
                }

            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        searchListOfCities = []
    }
    
    
    
}


extension SearchListOfCitiesController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Что в массиве \(searchListOfCities)")
        return searchListOfCities?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let city = searchListOfCities?[indexPath.row]
            cell.textLabel?.text = "\(city?.name ?? ""), \(city?.country ?? ""), \(city?.state ?? "")"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coordinates = CoordinatesFromSearchListModel(lat: searchListOfCities?[indexPath.row].lat ?? 0, lon: searchListOfCities?[indexPath.row].lon ?? 0)
        self.delegate?.changeCoordinatesOnMain(coordinates: coordinates)
    }
    
    
}

extension SearchListOfCitiesController: UITableViewDelegate {
    
}

extension SearchListOfCitiesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // тестируем
        let searchText = searchController.searchBar.text!
        var updateSearchText: String = ""
        for i in searchText {
            let ii = String(i)
            if ii == " " {
                updateSearchText += "-"
            } else {
                updateSearchText += ii
            }
        }
        fetchListCity(city: updateSearchText)
        //tableView.reloadData()
    }
    
    
}
