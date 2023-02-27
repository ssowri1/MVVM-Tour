//
//  NSObject+Extention.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import Foundation

extension NSObject {
    public class var onlyClassName: String {
        return String(describing: self).components(separatedBy: ".").last ?? ""
    }
}
