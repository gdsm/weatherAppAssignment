//
//  CloudModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Foundation

struct CloudModel: Hashable {
    let all: Int
    
    init(model: NetCloudModel) {
        self.all = model.all
    }
}
