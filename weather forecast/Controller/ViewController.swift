//
//  ViewController.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 24.10.2022.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.attributedTitle = NSAttributedString(string: "Идет обновление...")
        control.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return control
    }()
    
//    private var firstSectionModel: MainCellModel?
//    private var secondSectionModel: InfoCellModel?
//    private var thirdSectionModel: [ForecastCellModel]?
    private var cityModel: CityModel?
   // private var searchListCityModel: SearchListOfCitiesModel?
    
   //private var locationManager = CLLocationManager()
    
   var locationManager: CLLocationManager!
    
    private let service = FetchWeatherNetwork()
    
    //private let searchListCity = SearchListOfCitiesController()
    
   // var favoritesCity: Array<String> = []
// var coordinatesCellModel: Array<CoordinatesCellModel> = []
    var favoritesCityArry: Array<CityModel?> = []
    private var lon: String = ""
    private var lat: String = ""
    private var id: Int = 0
    
//        didSet {
//            let existCity = !coordinatesCellModel.filter { $0.id == cityModel?.firstSectionModel?.id }.isEmpty
//            print(existCity)
//            if existCity {
//                let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
//                let image = UIImage(systemName: "star.fill", withConfiguration: config)
//                rightButton.setImage(image, for: .normal)
//                favoritesOnOff = true
//            } else {
//                let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
//                let image = UIImage(systemName: "star", withConfiguration: config)
//                rightButton.setImage(image, for: .normal)
//                favoritesOnOff = false
//            }
//        }
//    }
    
    let viewForNavigationBar: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let leftButton: UIButton = {
        let button = UIButton()
        //button.setImage(UIImage(named: "menu"), for: .normal)
        button.setImage(UIImage(named: "menu"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        //button.imageView?.backgroundColor = #colorLiteral(red: 0.8398272395, green: 0.9403695464, blue: 0.9815813899, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var searchBar: UISearchController = {
        //let search = UISearchBar()
        let searchList = SearchListOfCitiesController()
        let search = UISearchController(searchResultsController: searchList)
        searchList.delegate = self
        search.searchResultsUpdater = searchList
        //search.translatesAutoresizingMaskIntoConstraints = false
        search.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    //let searchBar = UISearchController(searchResultsController: nil)
    
    private func setupSearchBar() {
//        let frame = CGRect(x: 0, y: 0, width: 100, height: 44)
//        let titleView = UIView(frame: frame)
//            searchBar.searchBar.backgroundImage = UIImage()
//        searchBar.searchBar.frame = frame
//        titleView.addSubview(searchBar.searchBar)
//        navigationItem.titleView = titleView
        
        navigationItem.searchController = searchBar
        navigationItem.titleView = viewForNavigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.alpha = 0.8
        searchBar.searchBar.delegate = self
        //searchBar.obscuresBackgroundDuringPresentation = false
    }
    
    
    
    let rightButton: UIButton = {
      let button = UIButton()
        //button.setImage(UIImage(systemName: "star"), for: .normal)
        let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
        let image = UIImage(systemName: "star", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .systemYellow
        button.imageView?.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let tableView: UITableView = {
       var table = UITableView()
       table.backgroundColor = #colorLiteral(red: 0.8398272395, green: 0.9403695464, blue: 0.9815813899, alpha: 1)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        //растояние контента до таблицы
        table.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setSettingsLocationManager()
        if (CLLocationManager.locationServicesEnabled()) {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        }
        
        //view.backgroundColor = #colorLiteral(red: 0.6449423432, green: 0.8703988791, blue: 0.9864518046, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.8398272395, green: 0.9403695464, blue: 0.9815813899, alpha: 1)
        addNewElement()
        addConstraintView()
        setupTable()
        getCities()
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
//        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: rightButton), UIBarButtonItem(customView: searchBar)]
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        //self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: rightButton)
        // делаем navigationBar прозрачным
        
        leftButton.addTarget(self, action: #selector(onMenuViewController), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        setupSearchBar()
        
        tableView.addSubview(refreshControl)
        cityModel = CityModel()
        
        
    }
    
    
    
    @objc func refresh() {
        fetchWeather(lon: lon, lat: lat)
    
    }
    
   
    
    @objc func onMenuViewController() {
        let controller = MenuViewController(coordinatesCityModel: favoritesCityArry)
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //var favoritesOnOff = false
    
    
    @objc func addToFavorites() {
        
        if cityModel?.favoritesOnOff == true {
            let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
            let image = UIImage(systemName: "star", withConfiguration: config)
            rightButton.setImage(image, for: .normal)
            cityModel?.favoritesOnOff = false
            favoritesCityArry.removeAll(where: {$0?.lon == cityModel?.lon && $0?.lat == cityModel?.lat})
            CoreDataCityManager.shared.delete(cityId: cityModel)
            print(favoritesCityArry)
        } else {
            let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
            let image = UIImage(systemName: "star.fill", withConfiguration: config)
            rightButton.setImage(image, for: .normal)
            cityModel?.favoritesOnOff = true
            favoritesCityArry.append(cityModel) //CoordinatesCellModel(lat: lat, lon: lon, id: id)
            //favoritesCity.append("Санкт-Петербург")
            CoreDataCityManager.shared.save(city: cityModel)
            print(favoritesCityArry)
        }
    }
    
    private func checkingFavorites() {
        if favoritesCityArry.filter({ $0?.id == cityModel?.id }).isEmpty {
            let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
            let image = UIImage(systemName: "star", withConfiguration: config)
            rightButton.setImage(image, for: .normal)
            cityModel?.favoritesOnOff = false
        } else {
            let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
            let image = UIImage(systemName: "star.fill", withConfiguration: config)
            rightButton.setImage(image, for: .normal)
            cityModel?.favoritesOnOff = true
        }
        
    }
    
    private func getCities() {
        CoreDataCityManager.shared.getCitites { [weak self] cities in
            guard let self = self else { return }
            self.favoritesCityArry = cities.map { CityModel(firstSectionModel: nil, secondSectionModel: nil, thirdSectionModel: nil, favoritesOnOff: $0.trueFalse, id: Int($0.id), lon: $0.lon, lat: $0.lat) }
            let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
            if self.favoritesCityArry.filter({ $0?.id == self.cityModel?.id }).isEmpty {
                let image = UIImage(systemName: "star", withConfiguration: config)
                self.rightButton.setImage(image, for: .normal)
            } else {
            let image = UIImage(systemName: "star.fill", withConfiguration: config)
                self.rightButton.setImage(image, for: .normal)
            }
            self.tableView.reloadData()
        }
    }
    
    private func addNewElement() {
        view.addSubview(tableView)
        viewForNavigationBar.addSubview(leftButton)
        //viewForNavigationBar.addSubview(searchBar)
        viewForNavigationBar.addSubview(searchBar.searchBar)
        viewForNavigationBar.addSubview(rightButton)
    }

    private func addConstraintView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            leftButton.topAnchor.constraint(equalTo: viewForNavigationBar.topAnchor),
            leftButton.widthAnchor.constraint(equalToConstant: 50),
            leftButton.bottomAnchor.constraint(equalTo: viewForNavigationBar.bottomAnchor, constant: -5),
            
            viewForNavigationBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            leftButton.centerYAnchor.constraint(equalTo: viewForNavigationBar.centerYAnchor),
            leftButton.leadingAnchor.constraint(equalTo: viewForNavigationBar.leadingAnchor),
            
            //searchBar.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 5),
            //searchBar.centerYAnchor.constraint(equalTo: viewForNavigationBar.centerYAnchor),
            searchBar.searchBar.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 25),
            searchBar.searchBar.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor, constant: -20),
            
            rightButton.centerYAnchor.constraint(equalTo: viewForNavigationBar.centerYAnchor),
           // rightButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 5),
            rightButton.trailingAnchor.constraint(equalTo: viewForNavigationBar.trailingAnchor, constant: -15)
        ])
    }
    
    private func fetchWeather(lon: String, lat: String) {
        let group = DispatchGroup()
        group.enter()
        service.fetchCurrentWeather(for: CoordinateWeatherSource(lat: lat, lon: lon)) { [weak self] result in
            switch result {
            case let .success(model):
                print(model)
                self?.cityModel?.firstSectionModel = MainCellModel(city: model.name, temp: "\(Int(model.main.temp))°", timeZone: model.timezone, weatherIcon: model.weather.first?.icon ?? " ", id: model.id)
                self?.cityModel?.id = model.id
                self?.cityModel?.lon = model.coord.lon
                self?.cityModel?.lat = model.coord.lat
                self?.cityModel?.secondSectionModel = InfoCellModel(element1: .init(title: "Восход", description: self?.transformTimeUnix(unix: model.sys.sunrise, timeZone: model.timezone) ?? "", image: UIImage(systemName: "sunrise")), element2: .init(title: "Ощущается", description: "\(model.main.feelsLike)", image: UIImage(systemName: "thermometer.sun")), element3: .init(title: "Закат", description: self?.transformTimeUnix(unix: model.sys.sunset, timeZone: model.timezone) ?? "", image: UIImage(systemName: "sunset")), element4: .init(title: "Ощущается", description: "\(model.main.feelsLike)", image: UIImage(systemName: "thermometer.sun")), element5: .init(title: "Скорость м/с", description: "\(model.wind.speed)", image: UIImage(systemName: "wind")), element6: .init(title: "Давление", description: "\(model.main.pressure)", image: UIImage(systemName: "person.wave.2")))
                
            case let .failure(error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        
        group.enter()
        service.fetchForecastWeather(for: WeatherFiveDaySource(lat: lat, lon: lon)) { [weak self] result in
            switch result {
            case let .success(model):
                print("ПРОГНОЗ 5 ДНЕЙ")
                
                let filter = model.list.filter({
                   print(self?.transformTimeUnix2(unix: $0.dt , timeZone: model.city.timezone))
                    return self?.transformTimeUnix2(unix: $0.dt , timeZone: model.city.timezone) ?? "" == "15:00" || self?.transformTimeUnix2(unix: $0.dt , timeZone: model.city.timezone) ?? "" == "14:00" || self?.transformTimeUnix2(unix: $0.dt , timeZone: model.city.timezone) ?? "" == "13:00" ||
                    self?.transformTimeUnix2(unix: $0.dt , timeZone: model.city.timezone) ?? "" == "14:30"
                })
                    .map {
                    ForecastCellModel(temp: $0.main.temp, icon: $0.weather.first?.icon ?? "")
                }
                print(filter)
                self?.cityModel?.thirdSectionModel = filter
                
            case let .failure(error):
                print(error.localizedDescription)
            }
            group.leave()
        }
        group.notify(queue: .main) {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.checkingFavorites()
        }
    }
    
//    private func fetchListCity(city: String) {
//        service.fetchListOfCities(for: СitySearch(city: city)) { [weak self] result in
//            switch result {
//            case let .success(model):
//                self?.searchListCityModel = SearchListOfCitiesModel(name: model.first?.name ?? "", lat: model.first?.lat ?? 0, lon: model.first?.lon ?? 0, country: model.first?.country ?? "", state: model.first?.state ?? "")
//                print("УАХАХАХАХХАХАХХА \(self?.searchListCityModel)")
//
//                DispatchQueue.main.async {
//                    let test = SearchListOfCitiesController()
//                    if let goga = self?.searchListCityModel {
//                        test.searchListOfCities.append(goga)
//
//                        DispatchQueue.main.async{
//                            test.tableView.reloadData()
//                        }
//                    }
//                    print("ТАК \(test.searchListOfCities)")
//                }
//
//            case let .failure(error):
//                print(error.localizedDescription)
//            }
//        }
//    }

    private func transformTimeUnix(unix: Double, timeZone: Int) -> String {
        let date = NSDate(timeIntervalSince1970: unix)

        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "HH:mm"
        dayTimePeriodFormatter.timeZone = NSTimeZone(forSecondsFromGMT: timeZone) as TimeZone?
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    private func transformTimeUnix2(unix: Double, timeZone: Int) -> String {
        let date = NSDate(timeIntervalSince1970: unix)
    
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "HH:mm"

        dayTimePeriodFormatter.timeZone = NSTimeZone(forSecondsFromGMT: timeZone) as TimeZone?
        let dateAsString = dayTimePeriodFormatter.string(from: date as Date)
        return dateAsString
        
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

extension ViewController {
    func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.identifier)
        tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.identifier)
        tableView.register(Forecast10Days.self, forCellReuseIdentifier: Forecast10Days.identifier)
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as? MainCell else {
            return UITableViewCell()
        }
            cell.setup(model: cityModel)
            return cell
        }
        else if indexPath.section == 1 {
        guard let infoCell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier, for: indexPath) as? InfoCell else {
            return UITableViewCell()
        }
            
//            infoCell.setup(model: .init(element1: .init(title: "Вос", description: "Jakarda", image: UIImage(systemName: "sun.max")), element2: .init(title: "Tyshkan4ik", description: "Tratatat", image: UIImage(systemName: "sunrise")), element3: .init(title: "Partos", description: "Tankomet", image: UIImage(systemName: "moon")), element4: .init(title: "Wind", description: "Wind", image: UIImage(systemName: "cloud.drizzle.fill")), element5: .init(title: "Sun", description: "Sun", image: UIImage(systemName: "sun.max")), element6: .init(title: "Dodo", description: "Good", image: UIImage(systemName: "snowflake"))))
            infoCell.setup(model: cityModel?.secondSectionModel)
            infoCell.delegate = self
        return infoCell
        } else {
            guard let forecast = tableView.dequeueReusableCell(withIdentifier: Forecast10Days.identifier, for: indexPath) as? Forecast10Days else {
                return UITableViewCell()
            }
            forecast.setup1(model: cityModel?.thirdSectionModel)
            return forecast
        }
    }
}

extension ViewController: InfoCellDelegate {
    func update(_ cell: InfoCell) {
        print(#function)
    }
    
    func showMore(_ cell: InfoCell) {
        let controller = MoreViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return UIScreen.main.bounds.height / 3.30
        }
        return UITableView.automaticDimension
    }
}

//extension ViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else { return }
//        fetchWeather(lon: "\(location.coordinate.longitude)", lat: "\(location.coordinate.latitude)")
//    }
//
//    private func setSettingsLocationManager() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//
//    }
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//
//            switch manager.authorizationStatus {
//                case .authorizedAlways , .authorizedWhenInUse:
//                locationManager.startUpdatingLocation()
//                case .notDetermined , .denied , .restricted:
//                print("NotDetermined")
//                default:
//                    break
//            }
//
//            switch manager.accuracyAuthorization {
//                case .fullAccuracy:
//                    break
//                case .reducedAccuracy:
//                    break
//                default:
//                    break
//            }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error.localizedDescription)
//    }
//}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation

        fetchWeather(lon: "\(location.coordinate.longitude)", lat: "\(location.coordinate.latitude)")
        lon = "\(location.coordinate.longitude)"
        lat = "\(location.coordinate.latitude)"
        print(cityModel?.favoritesOnOff)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: MenuViewControllerDelegate {
    func changeCoordinateCity(coordinate: CoordinatesCellModel?) {
        if id != coordinate?.id {
        fetchWeather(lon: coordinate?.lon ?? "", lat: coordinate?.lat ?? "")
            lon = coordinate?.lon ?? ""
            lat = coordinate?.lat ?? ""
        }
    }
    
    func deleteCityFromFavorite(id: FavoritesCellModel?) {
        if id?.id == cityModel?.firstSectionModel?.id {
        let config = UIImage.SymbolConfiguration(pointSize: UIScreen.main.bounds.width / 17, weight: .medium, scale: .default)
        let image = UIImage(systemName: "star", withConfiguration: config)
        rightButton.setImage(image, for: .normal)
                cityModel?.favoritesOnOff = false
        }
        favoritesCityArry.removeAll(where: {$0?.id == id?.id})
    }
}



extension ViewController: UISearchControllerDelegate, UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//  //     fetchListCity(city: searchText)
//    }
}

extension ViewController: SearchListOfCitiesControllerDelegate {
    func changeCoordinatesOnMain(coordinates: CoordinatesFromSearchListModel?) {
        fetchWeather(lon: "\(coordinates?.lon ?? 0)", lat: "\(coordinates?.lat ?? 0)")
            lon = "\(coordinates?.lon ?? 0)"
            lat = "\(coordinates?.lat ?? 0)"
        }
    
}
