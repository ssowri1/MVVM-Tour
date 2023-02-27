//
//  WeatherDetailsCoordinator.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import Foundation
import UIKit

extension MainCoordinator {
    func showWeatherDeatils<T: Any>(payload: T) {
        let vc = WeatherDetailsViewController.instantiate()
        vc.coordinator = self
        let vm = WeatherDetailViewModel(data: (payload as? WeatherData)!)
        vc.viewModel = vm
        navigationController.pushViewController(vc, animated: true)
    }
}
