//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    @ObservedObject var viewModel: CurrentWeatherViewModel
        
    var body: some View {
        VStack {
            switch viewModel.downloadState {
            case .error(let message):
                Text("Failed to fetch data : \(message)")
            case .inProgress:
                Text("Fetching weather data.")
            case .permissionError:
                Text(LocalisedString.permissionRequiredMessage)
                    .alert(isPresented: .constant(true), content: {
                        Alert(
                            title: Text(LocalisedString.permissionRequired),
                            message: Text(LocalisedString.permissionRequiredMessage),
                            primaryButton: .default(Text("OK")) {
                                PermissionHelper.openSettings()
                            },
                            secondaryButton: .cancel()
                        )
                    })
            case .notStarted:
                Text("Weather data request not started.")
            case .finished:
                getDisplayView()
            }
        }
        .onAppear() {
            viewModel.getWeatherData()
        }
    }
    
    func getDisplayView() -> some View {
        return VStack {
            HStack {
                Text("Temperature : ")
                Text("\(viewModel.currentWeather!.temperature.tempCelsius())")
            }
            .padding()
            
            HStack {
                Text("wind speed: ")
                Text("\(viewModel.currentWeather!.wind.speedText())")
            }
        }
    }
}

#Preview {
    CurrentWeatherView(
        viewModel: CurrentWeatherViewModel(repo: NoOpWeatherDataRepo())
    )
}
