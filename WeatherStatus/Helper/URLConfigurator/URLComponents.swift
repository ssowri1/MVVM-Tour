//
//  URLComponents.swift
//  WeatherStatus
//
//  Created by Sowrirajan S on 10/02/23.
//

import Foundation

public typealias Parameters = [String: String]

public var defaultLocation: [String: String] {
    return [QueryItems.q.rawValue: AppGeneral.defaultPlace]
}

private var auth: [String: String] {
    return [QueryItems.appId.rawValue: ApiConstansts.apiKey]
}

private var unit: [String: String] {
    return [:]
}

extension ApiConstansts {
    static func fetchUrl(_ payload: Parameters? = defaultLocation, endPoint: String = "") -> URLRequest? {
        return payload?.isEmpty ?? false ? configuration(path, query: defaultLocation) : configuration(path, query: payload)
    }
    
    // configuring api
    static func configuration(_ path: String, _ endPoint: String = "", query: [String: String]?) -> URLRequest? {
        let additionalConfig = auth.merging(unit) { key, value in value }
        let queryData = query?.merging(additionalConfig, uniquingKeysWith: { key, value in value })
        var url: URL? {
            var components = URLComponents()
            components.scheme = scheme
            components.host = host
            components.path = path
            components.setQueryItems(with: queryData ?? auth)
            debugPrint("URL ==>> ", components.url as Any)
            return components.url?.appendingPathComponent(endPoint)
        }
        
        guard let url = url else { return nil }
        let request = URLRequest(url: url)
        return request
    }
}

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
