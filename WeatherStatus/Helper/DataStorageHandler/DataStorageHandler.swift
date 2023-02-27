//
//  DatabaseHandler.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import Foundation
import CoreData
import UIKit

class DataStorageHandler {
    
    public static var shared = DataStorageHandler()

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var managedContext: NSManagedObjectContext {
        return self.appDelegate.persistentContainer.viewContext
    }
    
    var timeStamp: String {
        return String(describing: Date().iso8601withFractionalSeconds)
    }
    
    private init() { }
    
    public func save(_ location: City, icon: String, completionHandler: @escaping() -> Void) {
        // Create Entity
        let entity = NSEntityDescription.entity(forEntityName: "WeatherData", in: managedContext)

        // Initialize Record
        let weatherData = NSManagedObject(entity: entity!, insertInto: managedContext)
        weatherData.setValue(location.id, forKey: "locationID")
        weatherData.setValue(location.country, forKey: "country")
        weatherData.setValue(location.coord.lat, forKey: "lat")
        weatherData.setValue(location.coord.lon, forKey: "lon")
        weatherData.setValue(location.name, forKey: "area")
        weatherData.setValue(icon, forKey: "icon")
        weatherData.setValue(timeStamp, forKey: "timeStamp")

        managedContext.performAndWait {
            do {
                try managedContext.save()
                completionHandler()
            } catch let error as NSError {
                completionHandler()
                print("could not save, managedobject \(error), \(error.userInfo)")
            }
        }
    }
    
    public func fetchAllSavedOptions() -> [WeatherData] {
        
        let request = WeatherData.fetchRequest()
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            return result
        } catch {
            print("fetch request failed, managedobject")
            return [WeatherData]()
        }
    }
}
