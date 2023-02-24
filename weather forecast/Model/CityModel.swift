//
//  CityModel.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 12.12.2022.
//

import Foundation
import UIKit

struct CityModel {
    var firstSectionModel: MainCellModel?
    var secondSectionModel: InfoCellModel?
    var thirdSectionModel: [ForecastCellModel]?
    var favoritesOnOff = false
    var id: Int?
    var lon: Double?
    var lat: Double?
}
