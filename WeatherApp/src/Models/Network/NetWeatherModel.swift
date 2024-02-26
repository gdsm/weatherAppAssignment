//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Foundation

struct NetWeatherModel: Codable, Hashable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
