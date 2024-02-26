//
//  MockLocationManager.swift
//  WeatherAppTests
//
//  Created by Gagandeep on 21/02/24.
//

import Combine
import Foundation
@testable import WeatherApp

struct MockLocationManager: LocationProtocol {
    let coordinate: LocationModel
    
    func getCurrentLocation() -> Future<LocationModel, LocationError> {
        return Future() { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                promise(Result.success(coordinate))
            }
        }
    }
}
