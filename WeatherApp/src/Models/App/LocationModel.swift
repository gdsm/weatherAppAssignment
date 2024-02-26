//
//  CoordinateModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Foundation

class LocationModel: Codable {
    let lat: Double
    let lon: Double
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
    
    private (set) var state: String?
    private (set) var country: String?
    
    func update(state: String?, country: String?) {
        self.state = state
        self.country = country
    }
}
