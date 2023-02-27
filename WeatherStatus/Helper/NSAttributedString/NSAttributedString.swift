//
//  NSAttributedString.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 18/02/23.
//

import UIKit

extension NSMutableAttributedString {
    
    func boldString(_ value: String, _ fontSize: CGFloat? = 14) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : WSFonts.KohinoorDevanagari.Semibold.size(fontSize!),
            .foregroundColor: UIColor.black
        ]
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func normalString(_ value: String, _ fontSize: CGFloat? = 14) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : WSFonts.KohinoorDevanagari.Regular.size(fontSize!),
        ]
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value: String, _ fontSize: CGFloat? = 14) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  WSFonts.KohinoorDevanagari.Regular.size(fontSize!),
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    func blackHighlight(_ value: String, _ fontSize: CGFloat? = 14) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  WSFonts.KohinoorDevanagari.Regular.size(fontSize!),
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black
        ]
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    func underlined(_ value:String, _ fontSize: CGFloat? = 14) -> NSMutableAttributedString {
        let attributes:[NSAttributedString.Key : Any] = [
            .font : WSFonts.KohinoorDevanagari.Regular.size(fontSize!),
            .underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}
