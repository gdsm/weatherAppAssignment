//
//  WeatherDataDownloadState.swift
//  WeatherApp
//
//  Created by Gagandeep on 20/02/24.
//

import Foundation

enum WeatherDataDownloadState: Equatable {
    case notStarted
    case inProgress
    case finished
    case permissionError
    case error(message: String)
}
