//
//  ParentViewController.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import UIKit

class ParentViewController: UIViewController, Storyboarded {
    var alertLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureAlert() {
        alertLabel.frame = CGRect(x: 20, y: 20, width: 110, height: 110)
        alertLabel.text = AppGeneral.loading
        alertLabel.textAlignment = .center
        alertLabel.center = self.view.center
        alertLabel.numberOfLines = 0
        alertLabel.lineBreakMode = .byWordWrapping
        view.addSubview(alertLabel)
        showAlert()
    }
    
    func showAlert(_ status: Bool = true) {
        alertLabel.isHidden = !status
    }
}
