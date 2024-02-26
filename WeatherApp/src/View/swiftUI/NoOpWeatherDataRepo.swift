//
//  MockWeatherDataRepo.swift
//  WeatherApp
//
//  Created by Gagandeep on 20/02/24.
//

import Foundation
import NetworkServices


struct NoOpWeatherDataRepo: CurrentWeatherProtocol, WeatherForecastProtocol {
    func getCurrentWeather(coord: LocationModel) async throws -> Result<CurrentWeatherModel, NetworkServices.ServiceError> {
        return .failure(.unknown)
    }
    
    func getWeatherForecast(coord: LocationModel) async throws -> Result<WeatherForecastModel, NetworkServices.ServiceError> {
        return .failure(.unknown)
    }
}
