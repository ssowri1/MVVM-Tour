//
//  AppFont.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import Foundation
import UIKit

public struct WSFonts {
    enum KohinoorDevanagari: String {
        case Regular = "KohinoorDevanagari-Regular"
        case Light = "KohinoorDevanagari-Light"
        case Semibold = "KohinoorDevanagari-Semibold"
        
        func size(_ size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }
}
