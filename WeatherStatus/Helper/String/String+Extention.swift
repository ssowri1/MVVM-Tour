//
//  String+Extention.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 11/02/23.
//

import Foundation

extension String {
    var degree: String {
        return self + AppGeneral.degreeUnicode
    }
    
    var percentage: String {
        return self + AppGeneral.percentage
    }
    
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSinceNow: Double(self) ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    func toDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = AppGeneral.dateFormatInput
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = AppGeneral.dateFormatOutput
        
        let date: NSDate? = dateFormatterGet.date(from: self) as NSDate?
        return dateFormatterPrint.string(from: date! as Date)
    }
    
    func getImageUrl() -> String! {
        return "http://openweathermap.org/img/wn/\(self)@2x.png"
    }
}
