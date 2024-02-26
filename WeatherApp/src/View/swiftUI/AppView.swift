//
//  AppView.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import SwiftUI

struct AppView: View {
    
    private var currentWeatherViewModel = CurrentWeatherViewModel(repo: WeatherDataRepoFactory.getWeatherDataRepo())
    private var forecastWeatherViewModel = WeatherForecastViewModel(repo: WeatherDataRepoFactory.getWeatherDataRepo())

    @State private var showCurrentWeather = false
    @State private var showWeatherForecast = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Button(LocalisedString.showCurrentweather) {
                    showCurrentWeather = true
                }
                .accessibilityIdentifier("showCurrentWeather")
                .padding()
                
                Button(LocalisedString.showWeatherForecast) {
                    showWeatherForecast = true
                }
                .accessibilityIdentifier("showWeatherForecast")
                .padding()
                
                NavigationLink(destination: getCurrentWeatherView(), isActive: $showCurrentWeather) {
                    EmptyView()
                }
                .hidden()
                
                NavigationLink(destination: getWeatherForecastView(), isActive: $showWeatherForecast) {
                    EmptyView()
                }
                .hidden()
            }
        }
    }
    
    func getCurrentWeatherView() -> some View{
        return CurrentWeatherView(viewModel: currentWeatherViewModel)
    }
    
    func getWeatherForecastView() -> some View{
        return WeatherForecastView(viewModel: forecastWeatherViewModel)
    }
}

#Preview {
    AppView()
}
