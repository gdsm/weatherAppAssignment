//
//  UnitsHelper.swift
//  WeatherApp
//
//  Created by Gagandeep on 21/02/24.
//

import Foundation

struct UnitsHelper {
    static func convertTemperature(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> Double {
        let input = Measurement(value: temp, unit: inputTempType)
        let output = input.converted(to: outputTempType)
        return output.value
    }
}
