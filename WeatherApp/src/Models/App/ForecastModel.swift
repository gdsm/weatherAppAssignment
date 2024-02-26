//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 20/02/24.
//

import Foundation


struct ForecastModel: Hashable {
    let date: Int
    let dateText: String
    let temperature: TemperatureModel
    let weather: [WeatherModel]
    let clouds: CloudModel
    let wind: WindModel
    let visibility: Int
    
    init(model: NetForecastModel) {
        self.date = model.date
        self.dateText = model.dateText
        self.temperature = TemperatureModel(model: model.temperature)
        self.weather = model.weather.map { WeatherModel(model: $0) }
        self.clouds = CloudModel(model: model.clouds)
        self.wind = WindModel(model: model.wind)
        self.visibility = model.visibility
    }
}
