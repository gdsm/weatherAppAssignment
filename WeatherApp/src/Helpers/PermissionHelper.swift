//
//  PermissionHelper.swift
//  WeatherApp
//
//  Created by Gagandeep on 21/02/24.
//

import UIKit


struct PermissionHelper {
    static func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
}
