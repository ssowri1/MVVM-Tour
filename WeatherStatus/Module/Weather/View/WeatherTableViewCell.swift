//
//  WeatherTableViewCell.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.cornerCurve()
        }
    }

    @IBOutlet weak var id: WSLabel! {
        didSet {
            id.configure(type: .body)
        }
    }
    
    @IBOutlet weak var name: WSLabel! {
        didSet {
            name.configure(type: .header)
        }
    }
    
    @IBOutlet weak var type: WSLabel! {
        didSet {
            type.configure(type: .body)
        }
    }
    
    @IBOutlet weak var icon: UIImageView!
    
    var data: WeatherData? {
        didSet {
            if let data = data {
                id.text = String(describing: Int(bitPattern: data.id))
                name.text = data.area
                type.text = data.country
                icon.imageFromURL((data.icon?.getImageUrl())!, placeHolder: placeHolderIcon)
            }
        }
    }
    
    var headerData: WeatherPayload! {
        didSet {
            id.text = headerData.id
            name.text = headerData.name
            type.text = headerData.type
        }
    }
}
