//
//  CoreDataManager.swift
//  weather forecast
//
//  Created by Виталий Троицкий on 08.01.2023.
//

import CoreData

final class CoreDataCityManager {
    static let shared: CoreDataCityManager = CoreDataCityManager()
    private let container = NSPersistentContainer(name: "CoreData")
    private let entityName = "DBCity"
    private var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    private init() {}
    
    /// Регистрация контейнера
    func registerContainer() {
        container.viewContext.mergePolicy = NSMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                assertionFailure("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    ///Метод сохранения в БД
    func save(city: CityModel?) {
        do {
            let dbCity = DBCity(context: context)
            dbCity.id = Int64(city?.id ?? 0)
            dbCity.lon = city?.lon ?? 0
                dbCity.lat = city?.lat ?? 0
            dbCity.trueFalse = ((city?.favoritesOnOff) != nil)
            try context.save()
        }
        catch {
            print("Save error")
        }
    }
    
    ///Метод выгрузки из БД
    func getCitites(completion: @escaping ([DBCity]) -> Void) {
        context.perform { [weak self] in
            guard let self = self else { return }
            do {
                let request = NSFetchRequest<DBCity>(entityName: self.entityName)
                let cities = try self.context.fetch(request)
                completion(cities)
            }
            catch {
                completion([])
                print("Request error ")
            }
        }
    }
    
    ///Метод удаление из БД
    func delete(cityId: CityModel?) {
        do {
            let request = NSFetchRequest<DBCity>(entityName: self.entityName)
            let cities = try self.context.fetch(request)
            if let city = cities.first(where: { $0.id == cityId?.id ?? 0}) {
                context.delete(city)
                try context.save()
            }
        }
        catch {
            print("Delete error")
        }
    }

} 
