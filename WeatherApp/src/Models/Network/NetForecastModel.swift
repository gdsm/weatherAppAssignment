//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 20/02/24.
//

import Foundation


struct NetForecastModel: Codable, Hashable {
    
    let date: Int
    let dateText: String
    let temperature: NetTemperatureModel
    let weather: [NetWeatherModel]
    let clouds: NetCloudModel
    let wind: NetWindModel
    let visibility: Int

    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case dateText = "dt_txt"
        case temperature = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case visibility = "visibility"
    }
}
