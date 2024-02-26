//
//  File.swift
//  WeatherApp
//
//  Created by Gagandeep on 20/02/24.
//

import Foundation

struct CityModel {
    let id: Int
    let name: String
    let coordinates: LocationModel
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
    
    init(model: NetCityModel) {
        self.id = model.id
        self.name = model.name
        self.coordinates = LocationModel(lat: model.coord.lat, lon: model.coord.lon)
        self.country = model.country
        self.population = model.population
        self.timezone = model.timezone
        self.sunrise = model.sunrise
        self.sunset = model.sunset
    }
}
