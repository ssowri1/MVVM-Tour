//
//  LocationHandler.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import Foundation
import CoreLocation

protocol LocationHandlerProtocol {
    func updateLocation(location: CLLocation)
}

class LocationHandler: NSObject {
    
    static let shared = LocationHandler()
    private override init() { }
    var delegate: LocationHandlerProtocol?
    
    var currentLocation: CLLocationCoordinate2D?
    var locationManager: CLLocationManager?
    
    func configureLocationManager(delegate: LocationHandlerProtocol) {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        self.delegate = delegate
    }
}

extension LocationHandler: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = locations.first else { return }
        delegate?.updateLocation(location: location)
    }
}
