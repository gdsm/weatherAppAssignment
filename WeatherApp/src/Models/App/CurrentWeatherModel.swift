//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Foundation

struct CurrentWeatherModel {
    let coordinates: LocationModel
    let weather: [WeatherModel]
    let base: String
    let temperature: TemperatureModel
    let visibility: Int
    let wind: WindModel
    let clouds: CloudModel
    
    let timezone: Int
    let id:Int
    let name: String
    let cod: Int
    
    init(model: NetCurrentWeatherModel) {
        self.coordinates = LocationModel(lat: model.coordinates.lat, lon: model.coordinates.lon)
        self.weather = model.weather.map { WeatherModel(model: $0) }
        self.base = model.base
        self.temperature = TemperatureModel(model: model.temperature)
        self.visibility = model.visibility
        self.wind = WindModel(model: model.wind)
        self.clouds = CloudModel(model: model.clouds)

        self.timezone = model.timezone
        self.id = model.id
        self.name = model.name
        self.cod = model.cod
    }
}
