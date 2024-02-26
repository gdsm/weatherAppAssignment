//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Foundation

struct NetCurrentWeatherModel: Codable {
    let coordinates: NetCoordinateModel
    let weather: [NetWeatherModel]
    let base: String
    let temperature: NetTemperatureModel
    let visibility: Int
    let wind: NetWindModel
    let clouds: NetCloudModel
    
    let timezone: Int
    let id:Int
    let name: String
    let cod: Int
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weather = "weather"
        case base = "base"
        case temperature = "main"
        case visibility = "visibility"
        case wind = "wind"
        case clouds = "clouds"

        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
}
