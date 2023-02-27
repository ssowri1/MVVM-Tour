//
//  WSLabel.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import Foundation
import UIKit

class WSLabel: UILabel {

    var size: CGFloat = FontSizes.body.rawValue
    var color: UIColor = .black
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        // This will call `awakeFromNib` in your code
        setup()
    }
    
    func configure(type: FontSizes, _ color: UIColor = .black) {
        self.size = type.rawValue
        self.color = color
        setup()
    }
    
    private func setup() {
        self.textColor = color
        self.font = WSFonts.KohinoorDevanagari.Regular.size(size)
    }
}
