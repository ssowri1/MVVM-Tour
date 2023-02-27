//
//  WeatherData+CoreDataProperties.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 16/02/23.
//
//

import Foundation
import CoreData


extension WeatherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherData> {
        return NSFetchRequest<WeatherData>(entityName: "WeatherData")
    }

    @NSManaged public var locationID: Int16
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var country: String?
    @NSManaged public var area: String?
    @NSManaged public var icon: String?

}

extension WeatherData : Identifiable {

}
