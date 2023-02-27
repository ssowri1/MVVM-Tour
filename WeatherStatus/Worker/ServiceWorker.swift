//
//  ServiceWorker.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import UIKit

class ServiceWorker: NSObject {
    /****
     To fetch data from server
     - Paremeters
        - request: URLRequest
        - viewController: UIViewController
        - closureHandler: @escaping(T)
     */
    class func fetch<T: Codable>(request: URLRequest, viewController: UIViewController, closureHandler: @escaping(T) -> Void) {
        
        URLSession.shared.dataTask(with: request) { (responseData, res, error) in
            
            let parentViewController = viewController as? ParentViewController
            
            guard error == nil else { return }
            
            guard let response = responseData else { return }
            
            do {
                let data = try JSONDecoder.init().decode(T.self, from: response)
                closureHandler(data)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }.resume()
    }
}
