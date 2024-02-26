//
//  WeatherForecastModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 20/02/24.
//

import Foundation

struct WeatherForecastModel {
    let cod: String
    let message: Int
    let numberOfTimeStamps: Int
    let city: CityModel
    let forecasts: [ForecastModel]
    
    init(model: NetWeatherForecastModel) {
        self.cod = model.cod
        self.message = model.message
        self.numberOfTimeStamps = model.numberOfTimeStamps
        self.city = CityModel(model: model.city)
        self.forecasts = model.forecasts.map { ForecastModel(model: $0) }
    }
}
