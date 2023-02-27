//
//  ViewModel.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import Foundation
import UIKit
import CoreLocation

class WeatherViewModel {
    var weatherDetails: WeatherResponseModel?
    typealias handler = (_ status: Bool) -> Void
    typealias NoActions = () -> Void
    
    var geoCoder = CLGeocoder()
    
    var weatherPersistence: [WeatherData]? {
        let localData = DataStorageHandler.shared.fetchAllSavedOptions()
        return localData
    }
    
    var featchWeather: [Weather]? {
        let weathers = weatherDetails?.list.map { $0 }.map { $0.weather }.map { $0.first! }
        return weathers
    }
    
    var featchCity: City? {
        return weatherDetails?.city
    }
    
    var numberOfRows: Int {
        return weatherPersistence?.count ?? 0
    }
    
    /****
     To Fetch the weather data from server
     - Paremeters
     - payload: Parameters
     - viewController: UIViewController
     - completionHandler: @escaping(NoActions)
     */
    func fetchWeatherData(payload: Parameters?,
                          viewController: UIViewController,
                          closureHanlder: @escaping(NoActions)) {
        guard let request = ApiConstansts.fetchUrl(payload) else { return }
        ServiceWorker.fetch(request: request, viewController: viewController) { [weak self] (responseData: WeatherResponseModel) in
            self?.weatherDetails = responseData
            closureHanlder()
        }
    }
    /****
     To get the weather based on the row of list
     - Paremeters
     - index: IndexPath
     - return: Weather
     */
    func getWeather(_ index: IndexPath) -> WeatherData? {
        return weatherPersistence?[index.row]
    }
    /****
     To search the location by typing on search bar.
     - Paremeters
     - controller: UIViewController
     - location: String?
     - completionHandler: @escaping(NoActions)
     */
    func searchLocation(_ controller: UIViewController, location: String?, completionsHandler: @escaping(NoActions)) {
        guard let area = location, area.count > 3 else { return }
        fetchLocation(controller, [QueryItems.q.rawValue: area], completionHandler: completionsHandler)
    }
    /****
     To fetch the defalut location & current location weather details. fetch current location if default location not available.
     - Paremeters
     - controller: UIViewController
     - payload: Parameters
     - completionHandler: @escaping(NoActions)
     */
    func fetchLocation(_ controller: UIViewController, _ payload: Parameters? = nil, completionHandler: @escaping(NoActions)) {
        if weatherPersistence?.count == 0 {
            self.fetch(controller, payload: defaultLocation, completionHandler: completionHandler)
        } else {
            self.fetch(controller, payload: payload, completionHandler: completionHandler)
        }
    }
    /****
     To store the place to local container
     - Paremeters
     - controller: UIViewController
     - payload: Parameters
     - completionHandler: @escaping(NoActions)
     */
    private func fetch(_ controller: UIViewController, payload: Parameters?, completionHandler: @escaping(NoActions)) {
        guard let payload = payload else { return }
        self.fetchWeatherData(payload: payload, viewController: controller) { [weak self] in
            DataStorageHandler.shared.save((self?.featchCity)!, icon: self?.featchWeather?.first?.icon ?? "", completionHandler: completionHandler)
        }
    }
    /****
     To separate the place from placemark
     - Paremeters
     - placemarks: [CLPlacemark]
     - completion: @escaping(String?)
     */
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, completion: @escaping(String?) -> Void) {
        if let placemarks = placemarks, let placemark = placemarks.first {
            completion(placemark.locality)
        }
    }
}
