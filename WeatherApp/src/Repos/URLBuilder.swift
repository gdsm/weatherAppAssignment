//
//  URLBuilder.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Foundation

protocol URLBuilder {
    func getBaseUrl() -> String
    func getAppId() -> String
}

enum URLEnvironment {
    case prod
    case qa
    case dev
}

extension URLEnvironment: URLBuilder {
    func getBaseUrl() -> String {
        switch self {
        case .prod, .qa, .dev:
            return "https://api.openweathermap.org/data/2.5/"
        }
    }
    
    func getAppId() -> String {
        switch self {
        case .prod:
            // TODO: Perform encrytption.
            return "appid=4f7a815f62f6d72f5d313000a748b8d2"
        case .qa, .dev:
            return "appid=4f7a815f62f6d72f5d313000a748b8d2"
        }
    }
}
