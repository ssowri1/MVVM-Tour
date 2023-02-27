//
//  WeatherDetailTableViewCell.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 12/02/23.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var feel: WSLabel!
    @IBOutlet weak var climate: WSLabel!

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.cornerCurve()
        }
    }
    
    @IBOutlet weak var temp: WSLabel! {
        didSet {
            temp.configure(type: .body)
        }
    }
    
    @IBOutlet weak var seaLevel: WSLabel!{
        didSet {
            seaLevel.configure(type: .body, .white)
        }
    }
    
    @IBOutlet weak var humidity: WSLabel!{
        didSet {
            humidity.configure(type: .body, .white)
        }
    }
    
    func configuredData(data: MainClass?, weather: Weather?) {
        if let tempValue = data?.temp, let feelValue = data?.feelsLike, let iconName = weather?.icon, let description = weather?.description, let seaLevelValue = data?.tempMax, let humidityValue = data?.humidity {
            let tempText = tempValue.convertTemp(from: .kelvin, to: .celsius)
            let feelText = feelValue.convertTemp(from: .kelvin, to: .celsius)
            let seaText = seaLevelValue.convertTemp(from: .kelvin, to: .celsius)

            temp.attributedText = NSMutableAttributedString().boldString(String(describing: tempText), 34)
            feel.text = "\(AppGeneral.feel): \n" + feelText
            climate.text = description
            seaLevel.text = "\(AppGeneral.tempMax): \n" + String(describing: seaText)
            humidity.text = "\(AppGeneral.humidity): \n" + String(describing: humidityValue).percentage
            icon.imageFromURL(iconName.getImageUrl(), placeHolder: placeHolderIcon)
        }
    }
}
