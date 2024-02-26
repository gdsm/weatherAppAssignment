//
//  File.swift
//  WeatherApp
//
//  Created by Gagandeep on 20/02/24.
//

import Foundation

struct NetCityModel: Codable {
    let id: Int
    let name: String
    let coord: NetCoordinateModel
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}
