//
//  WeatherForecastModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 20/02/24.
//

import Foundation

struct NetWeatherForecastModel: Codable {
    let cod: String
    let message: Int
    let numberOfTimeStamps: Int
    let city: NetCityModel
    let forecasts: [NetForecastModel]
    
    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case message = "message"
        case numberOfTimeStamps = "cnt"
        case city = "city"
        case forecasts = "list"
    }
}
