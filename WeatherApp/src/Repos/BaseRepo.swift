//
//  BaseRepo.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Foundation
import NetworkServices


/// Base repo enforces all inherited class to handle urlBuilder and network interface.
protocol BaseRepo {
    var urlBuilder: URLBuilder { get }
    var networkInterface: NetworkProtocol { get }
}
