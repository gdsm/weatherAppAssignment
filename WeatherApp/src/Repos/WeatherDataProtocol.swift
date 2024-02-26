//
//  WeatherDataProtocol.swift
//  WeatherApp
//
//  Created by Gagandeep on 20/02/24.
//

import Foundation
import NetworkServices

protocol CurrentWeatherProtocol {
    /// Method fetched current weather forecast from service. External server is third party server and have restrictions on it.
    /// Network request will transform Network Model to AppModels. This is to avoid any tempering of Models connected with API.
    /// - Parameter coord: Current coordinates
    /// - Returns: Return Current weather data or error
    func getCurrentWeather(coord: LocationModel) async throws -> Result<CurrentWeatherModel, ServiceError>
}

protocol WeatherForecastProtocol {
    /// Method fetched current weather forecast from service. External server is third party server and have restrictions on it.
    /// Network request will transform Network Model to AppModels. This is to avoid any tempering of Models connected with API.
    /// - Parameter coord: Current coordinates
    /// - Returns: Return Current weather data or error
    func getWeatherForecast(coord: LocationModel) async throws -> Result<WeatherForecastModel, ServiceError>
}
