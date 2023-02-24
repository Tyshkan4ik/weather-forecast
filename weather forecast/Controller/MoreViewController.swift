//
//  MoreViewController.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 14.11.2022.
//

import UIKit
import CoreLocation
import MapKit

class MoreViewController: UIViewController {
    
    private var moreCellModel: MoreCellModel?
    
    var locationManager: CLLocationManager!
    
    private let service = FetchWeatherNetwork()
    
    private var tableView: UITableView = {
       let table = UITableView()
        table.backgroundColor = #colorLiteral(red: 0.8398272395, green: 0.9403695464, blue: 0.9815813899, alpha: 1)
        table.translatesAutoresizingMaskIntoConstraints = false
       return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.locationServicesEnabled()) {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        }
        
        view.backgroundColor = #colorLiteral(red: 0.8398272395, green: 0.9403695464, blue: 0.9815813899, alpha: 1)
        newElement()
        newConstraintsOnView()
        setupTable()
    }
    
    private func newElement() {
        view.addSubview(tableView)
    }
    
    private func newConstraintsOnView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func fetchWeather(lon: String, lat: String) {
        service.fetchCurrentWeather(for: CoordinateWeatherSource(lat: lat, lon: lon)) { [weak self] result in
            switch result {
            case let .success(model):
                self?.moreCellModel = MoreCellModel(row: [[.init(icon: UIImage(systemName: "thermometer"), titl: "Температура", valueTitle: "\(model.main.temp)")], [.init(icon: UIImage(systemName: "figure.wave"), titl: "Ощущается как", valueTitle: "\(model.main.feelsLike)")], [.init(icon: self?.transformIconInfoCell(icon: (model.weather.first?.icon) ?? ""), titl: "Текущая погода", valueTitle: model.weather.first?.description ?? "")], [.init(icon: UIImage(systemName: "thermometer.snowflake"), titl: "Минимальная температура", valueTitle: "\(model.main.tempMin)")], [.init(icon: UIImage(systemName: "thermometer.sun"), titl: "Максимальная температура", valueTitle: "\(model.main.tempMax)")], [.init(icon: UIImage(systemName: "person.wave.2"), titl: "Атмосферное давление", valueTitle: "\(model.main.pressure)")], [.init(icon: UIImage(systemName: "humidity"), titl: "Влажность", valueTitle: "\(model.main.humidity)")], [.init(icon: UIImage(systemName: "chevron.compact.up"), titl: "Уровень моря", valueTitle: "\(model.main.seaLevel ?? 0)")], [.init(icon: UIImage(systemName: "wind"), titl: "Скорость ветра", valueTitle: "\(model.wind.speed)")], [.init(icon: UIImage(systemName: "wind.snow"), titl: "Порывы ветра", valueTitle: "\(model.wind.gust ?? 0)")], [.init(icon: UIImage(systemName: "smoke"), titl: "Облака", valueTitle: "\(model.clouds.all)")] ])
                print("Ку ку")
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func transformIconInfoCell(icon: String) -> UIImage? {
        switch icon {
        case "01d":
            return UIImage(systemName: "sun")
        case "01n":
            return UIImage(systemName: "moon")
        case "02d":
            return UIImage(systemName: "cloud.sun")
        case "02n":
            return UIImage(systemName: "cloud.moon")
        case "03d", "03n":
            return UIImage(systemName: "cloud")
        case "04d", "04n":
            return UIImage(systemName: "smoke")
        case "09d", "09n":
            return UIImage(systemName: "cloud.drizzle")
        case "010d":
            return UIImage(systemName: "cloud.sun.rain")
        case "010n":
            return UIImage(systemName: "cloud.moon.rain")
        case "11d", "11n":
            return UIImage(systemName: "cloud.bolt")
        case "13d", "13n":
            return UIImage(systemName: "snowflake")
        case "50d", "50n":
            return UIImage(systemName: "aqi.high")
        default:
            return UIImage(systemName: "cloud")
        }
    }

    

}

extension MoreViewController {
    func setupTable() {
    tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MoreCell.self, forCellReuseIdentifier: MoreCell.identifier)
    }
}

extension MoreViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //moreCellModel?.row.count ?? 0
        moreCellModel?.row.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoreCell.identifier, for: indexPath) as? MoreCell else {
            return UITableViewCell()
        }
        let test = moreCellModel?.row[indexPath.row]
        cell.setup(model: test)
        return cell
    }
    
}

extension MoreViewController: UITableViewDelegate {
    
}

extension MoreViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation

        fetchWeather(lon: "\(location.coordinate.longitude)", lat: "\(location.coordinate.latitude)")

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
