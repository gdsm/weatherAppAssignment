//
//  WeatherForecastViewModel.swift
//  WeatherApp
//
//  Created by Gagandeep on 20/02/24.
//

import Combine
import NetworkServices
import Logging

/// Observable ViewModel weather forecast.
class WeatherForecastViewModel: ObservableObject {
    
    @Published var forecast: WeatherForecastModel?
    @Published var downloadState: WeatherDataDownloadState = .notStarted

    private var currentLocationCancellable: Cancellable?
    private let locationManager: LocationProtocol
    private let repo: WeatherForecastProtocol

    init(
        locationManager: LocationProtocol = LocationManager(),
        repo: WeatherForecastProtocol
    ) {
        self.locationManager = locationManager
        self.repo = repo
    }
    
    /// Method fetched weather forecast data. Forecast is for 3 hours frequency for 5 days.
    func getWeatherData() {
        // TODO: Check if data is stale based on timestamp.
        downloadState = .inProgress
        // cancel previous subscription
        currentLocationCancellable?.cancel()
        // Listen Current Location
        currentLocationCancellable = locationManager.getCurrentLocation().sink { [weak self] failureValue in
            guard let self = self else {
                Log.error("Instance deallocated.")
                return
            }
            if case .failure(let error) = failureValue {
                switch error {
                case .permissionRequired:
                    downloadState = .permissionError
                default:
                    downloadState = .error(message: "Error while fetching location.")
                }
            }
        } receiveValue: { [weak self] value in
            guard let self = self else {
                Log.error("Instance deallocated.")
                return
            }
            self.fetchWeatherForecast(coordinate: value)
        }
    }
    
    func reset() {
        downloadState = .notStarted
        forecast = nil
    }
    
    private func fetchWeatherForecast(coordinate: LocationModel) {
        Task {
            do {
                let result = try await repo.getWeatherForecast(coord: coordinate)
                switch result {
                case .success(let model):
                    Log.debug("Successfully got current weather forecast data")
                    DispatchQueue.main.async {
                        self.downloadState = .finished
                        self.forecast = model
                    }
                case .failure(_):
                    Log.error("Error in Fetching current Weather")
                    DispatchQueue.main.async {
                        self.downloadState = .error(message: "Unable to fetch weather data.")
                    }
                }
            } catch (let exception) {
                Log.error("Error in Fetching current Weather \(exception)")
            }
        }
    }
}
