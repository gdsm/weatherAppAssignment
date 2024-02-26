//
//  TemperatureModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Foundation


struct NetTemperatureModel: Codable, Hashable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int?
    let grnd_level: Int?
}
