//
//  WindModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Foundation

struct NetWindModel: Codable, Hashable {
    let speed: Double
    let deg: Int
    let gust: Double?
}
