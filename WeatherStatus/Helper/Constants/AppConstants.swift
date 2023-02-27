//
//  AppConstants.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import Foundation
import UIKit

struct ApiConstansts {
    // scheme
    static let scheme: String = "https"
    // host
    static let host: String = "api.openweathermap.org"
    // path
    static let path: String = "/data/2.5/forecast"
    // apiKey
    static let apiKey: String = "e116ffa8c1a75325a76f10940de1ead8"
}

enum QueryItems: String {
    case q = "q"
    case appId = "appid"
    case unit = "units"
    case metric = "metric"
}
//
struct AppGeneral {
    // String
    static let loading = "Loading..."
    static let weatherTitle = "Weathers"
    static let detailsTitle = "Upcoming status"
    static let latitude = "lat"
    static let longitude = "lon"
    static let temp = "Temp"
    static let feel = "Feel"
    static let pressure = "Pressure"
    static let onGround = "On Ground"
    static let seaLevel = "On Sea"
    static let tempMax = "Temp Max"
    static let humidity = "Humidity"
    static let id = "ID"
    static let name = "Name"
    static let type = "Country"
    static let cityNotFound = "City not found"
    static let cloud = "cloud"
    static let defaultPlace = "London,us"
    
    // Number
    static let numberOfSection = 1
    static let numberOfRows = 1
    static let heightOfCell: CGFloat = 70
    static let heightOfHeader: CGFloat = 50
    static let heightOfDetailCell: CGFloat = 120
    
    // Date
    static let dateFormatInput = "yyyy-MM-dd HH:mm:ss"
    static let dateFormatOutput = "MMM dd,yyyy"
    
    // Symbols
    static let degreeUnicode = "℃"
    static let percentage = "%"
}

enum FontSizes: CGFloat {
    case title = 20
    case header = 18
    case body = 14
    case footer = 10
}

let placeHolderIcon = UIImage(named: AppGeneral.cloud)
