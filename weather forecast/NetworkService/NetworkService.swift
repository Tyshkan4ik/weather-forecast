//
//  NetworkService.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 18.11.2022.
//

import Foundation

class NetworkService {
    func fetch<T: Decodable>(with request: URLRequest, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else {
                completion(.failure(FetchError.noDataReceived))
                return
            }
            
            do {
                let object = try decoder.decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    private enum FetchError: Error {
        case noHTTPResponse
        case noDataReceived
        case unacceptableStatusCode
    }
}

protocol WeatherSource {
    var urlRequest: URLRequest? { get }
}

extension WeatherSource {
    var token: String {
        return "1e3d0428bdc917c421e87a8b9a19fcde"
    }
}

struct CoordinateWeatherSource: WeatherSource {
    let lat: String
    let lon: String
    var url: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric&lang=ru&appid=\(token)")!
    }
    
    var urlRequest: URLRequest? {
        return URLRequest(url: url)
    }
}

struct WeatherFiveDaySource: WeatherSource {
    let lat: String
    let lon: String
    var url: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric&lang=ru&appid=1e3d0428bdc917c421e87a8b9a19fcde")!
    }

    var urlRequest: URLRequest? {
        return URLRequest(url: url)
    }
}

struct СitySearch: WeatherSource {
    let city: String
    var url: URL {
        if URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=5&appid=1e3d0428bdc917c421e87a8b9a19fcde") != nil {
            return URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=5&appid=1e3d0428bdc917c421e87a8b9a19fcde")!
        } else {
            return URL(string: "http://api.openweathermap.org/geo/1.0/direct?q=&limit=5&appid=1e3d0428bdc917c421e87a8b9a19fcde")!
        }
    }

    var urlRequest: URLRequest? {
        return URLRequest(url: url)
    }
}

struct FetchWeatherNetwork {
    let networkingService = NetworkService()
    
    func fetchCurrentWeather(for source: WeatherSource, completion: @escaping (Result<CurrentWeatherModel, Error>) -> Void) {
        let request = source
        networkingService.fetch(with: request.urlRequest!, completion: completion)
    }
    
    func fetchForecastWeather(for source: WeatherSource, completion: @escaping (Result<ForecastWeatherModel, Error>) -> Void) {
        let request = source
        networkingService.fetch(with: request.urlRequest!, completion: completion)
    }
    
    func fetchListOfCities(for source: WeatherSource, completion: @escaping (Result<[ListOfCitiesModel], Error>) -> Void) {
        let request = source
        networkingService.fetch(with: request.urlRequest!, completion: completion)
    }
}

/*
 {
   "coord": {
     "lon": 10.99,
     "lat": 44.34
   },
   "weather": [
     {
       "id": 501,
       "main": "Rain",
       "description": "moderate rain",
       "icon": "10d"
     }
 "main": {
     "temp": 298.48,
     "feels_like": 298.74,
     "temp_min": 297.56,
     "temp_max": 300.05,
     "pressure": 1015,
     "humidity": 64,
     "sea_level": 1015,
     "grnd_level": 933
   }
   ]
 "sys": {
     "type": 2,
     "id": 2075663,
     "country": "IT",
     "sunrise": 1661834187,
     "sunset": 1661882248
   },
 */


struct CurrentWeatherModel: Decodable {
    let coord: Coord
    let weather: [Weather]
    let timezone: Int
    let name: String
    let main: Main
    let sys: Sys
    let wind: Wind
    let clouds: Clouds
    let id: Int
    
    
    enum CodingKeys: String, CodingKey {
        case coord, weather, timezone, name, main, sys, wind, clouds, id
    }
    struct Coord: Decodable {
        let lon: Double
        let lat: Double
    }
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    struct Main: Decodable {
        let temp: Double
        let feelsLike: Double
       let pressure: Int
        let tempMin: Double
        let tempMax: Double
        let humidity: Int
        let seaLevel: Int?
        
        enum CodingKeys: String, CodingKey {
            case temp, pressure, humidity
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case seaLevel = "sea_level"
        }
    }
    
    struct Sys: Decodable {
        let sunrise: Double
        let sunset: Double
    }
    
    struct Wind: Decodable {
        let speed: Double
        let gust: Double?
    }
    
    struct Clouds: Decodable {
        let all: Int
    }
}



struct ForecastWeatherModel: Decodable {
    let city: City
    let list: [List]
    
    struct List: Decodable {
        let dt: Double
        let main: Main
        let dtTxt: String
        let weather: [Weather]
        
        struct Main: Decodable {
            let temp: Double
        }
        enum CodingKeys: String, CodingKey {
            case dt, main, weather
            case dtTxt = "dt_txt"
        }
        
        struct Weather: Decodable {
            let icon: String
    }
    }
    
    struct City: Decodable {
        let coord: Coord
        let name: String
        let timezone: Int
        
        struct Coord: Decodable {
            let lon: Double
            let lat: Double
        }
    }
}

struct ListOfCitiesModel: Decodable {
    //let localNames: LocalNames
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    
//    struct LocalNames: Decodable {
//        let en: String
//        let ru: String
//    }
    
//    enum CodingKeys: String, CodingKey {
//        case name, lat, lon, country, state
//        case localNames = "local_names"
//    }
}
