//
//  WindModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Foundation

struct WindModel: Hashable {
    let speed: Double
    let deg: Int
    let gust: Double?
    
    func speedText() -> String {
        return "\(speed) meter/sec"
    }
    
    init(model: NetWindModel) {
        self.speed = model.speed
        self.deg = model.deg
        self.gust = model.gust
    }
}
