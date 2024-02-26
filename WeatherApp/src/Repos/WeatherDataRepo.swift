//
//  WeatherDataRepo.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Foundation
import NetworkServices

/// Repo class to get weather data.
class WeatherDataRepo: BaseRepo {
    let urlBuilder: URLBuilder
    let networkInterface: NetworkProtocol
    
    /// MARK: Init methods
    init(urlBuilder: URLBuilder, networkInterface: NetworkProtocol) {
        self.urlBuilder = urlBuilder
        self.networkInterface = networkInterface
    }
    
    /// Builder method to URL
    /// - Parameter coord: Lat , Lon coordinates.
    /// - Returns: Method return optional url.
    internal func buildUrl(coord: LocationModel, secondaryUrl: String) -> URL? {
        var strUrl: String
        if let value = coord.state {
            strUrl = "\(urlBuilder.getBaseUrl())\(secondaryUrl)?q=\(value)&\(urlBuilder.getAppId())"
        } else if let value = coord.country {
            strUrl = "\(urlBuilder.getBaseUrl())\(secondaryUrl)?q=\(value)&\(urlBuilder.getAppId())"
        } else {
            strUrl = "\(urlBuilder.getBaseUrl())\(secondaryUrl)?lat=\(coord.lat)&lon=\(coord.lon)&\(urlBuilder.getAppId())"
        }
        return URL(string: strUrl)
    }
}

extension WeatherDataRepo: CurrentWeatherProtocol {
    func getCurrentWeather(coord: LocationModel) async throws -> Result<CurrentWeatherModel, ServiceError> {
        guard let url = buildUrl(coord: coord, secondaryUrl: "weather") else {
            return Result.failure(ServiceError.unknown)
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        let result: Result<NetCurrentWeatherModel, ServiceError> = try await networkInterface.request(urlRequest: request)
        switch result {
        case .success(let model):
            return .success(CurrentWeatherModel(model: model))
        case .failure(let error):
            return .failure(error)
        }
    }
}

extension WeatherDataRepo: WeatherForecastProtocol {
    func getWeatherForecast(coord: LocationModel) async throws -> Result<WeatherForecastModel, ServiceError> {
        guard let url = buildUrl(coord: coord, secondaryUrl: "forecast") else {
            return Result.failure(ServiceError.unknown)
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        let result: Result<NetWeatherForecastModel, ServiceError> = try await networkInterface.request(urlRequest: request)
        switch result {
        case .success(let model):
            return .success(WeatherForecastModel(model: model))
        case .failure(let error):
            return .failure(error)
        }
    }
}
