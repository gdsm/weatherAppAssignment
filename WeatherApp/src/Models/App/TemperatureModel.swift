//
//  TemperatureModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Foundation


struct TemperatureModel: Hashable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int?
    let grnd_level: Int?
    
    func tempCelsius() -> String {
        let celTemp = UnitsHelper.convertTemperature(temp: temp, from: .kelvin, to: .celsius)
        let value = String(format: "%.2f", celTemp)
        return "\(value) Cel"
    }
    
    init(model: NetTemperatureModel) {
        self.temp = model.temp
        self.feels_like = model.feels_like
        self.temp_min = model.temp_min
        self.temp_max = model.temp_max
        self.pressure = model.pressure
        self.humidity = model.humidity
        self.sea_level = model.sea_level
        self.grnd_level = model.grnd_level
    }
}
