//
//  LocalisedString.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Foundation

/// Container encapsulates all strings and one place. This is helpfull to localisation. L10n library can later be integrated to provide localisation.
struct LocalisedString {
    static let showCurrentweather = "Show current weather"
    static let showWeatherForecast = "Show weather forecast"
    
    static let permissionRequired = "Permission required"
    static let permissionRequiredMessage = "Weather app needs location permission in order to fetch current location."
}
