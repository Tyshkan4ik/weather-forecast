//
//  DBCity.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 08.01.2023.
//

import CoreData

@objc(DBCity)

class DBCity: NSManagedObject {
    @NSManaged var id: Int64
    @NSManaged var lat: Double
    @NSManaged var lon: Double
    @NSManaged var trueFalse: Bool
}
