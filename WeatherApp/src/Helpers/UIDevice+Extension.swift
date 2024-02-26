//
//  UIDevice+Extension.swift
//  WeatherApp
//
//  Created by Gagandeep on 22/02/24.
//

import UIKit

extension UIDevice {
    static var isSimulator: Bool = {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }()
}
