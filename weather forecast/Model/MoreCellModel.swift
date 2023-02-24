//
//  MoreCellModel.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 28.11.2022.
//

import Foundation
import UIKit

struct MoreCellModel {
    let row: [[Row]]

    struct Row {
    let icon: UIImage?
    let titl: String
    let valueTitle: String
    }
}
