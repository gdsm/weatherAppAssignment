//
//  MockCurrentWeatherData.swift
//  WeatherAppTests
//
//  Created by Gagandeep on 21/02/24.
//

import Foundation
@testable import NetworkServices
@testable import WeatherApp

struct MockCurrentWeatherRepo: CurrentWeatherProtocol {
    let result: Result<CurrentWeatherModel, ServiceError>

    func getCurrentWeather(coord: WeatherApp.LocationModel) async throws -> Result<CurrentWeatherModel, ServiceError> {
        return result
    }
    
    static func mockData(coordinate: LocationModel, temp: Double) -> CurrentWeatherModel? {
        guard let data = currentWeatherMockData(coordinate, temp).data(using: .utf8) else {
            return nil
        }
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(NetCurrentWeatherModel.self, from: data)
            return CurrentWeatherModel(model: response)
        } catch {
            return nil
        }
    }
    
    static let currentWeatherMockData = { (coord: LocationModel, temp: Double) -> String in
        """
        {"coord":{"lon":\(coord.lon),"lat":\(coord.lat)},"weather":[{"id":802,"main":"Clouds","description":"scattered clouds","icon":"03n"}],"base":"stations","main":{"temp":\(temp),"feels_like":\(temp),"temp_min":\(temp),"temp_max":\(temp),"pressure":1026,"humidity":71,"sea_level":1026,"grnd_level":937},"visibility":10000,"wind":{"speed":1.51,"deg":222,"gust":1.4},"clouds":{"all":29},"dt":1708488007,"sys":{"type":2,"id":2011351,"country":"IT","sunrise":1708495678,"sunset":1708534311},"timezone":3600,"id":3163858,"name":"Zocca","cod":200}

"""
    }
}
