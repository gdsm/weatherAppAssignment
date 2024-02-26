//
//  WeatherDataHelper.swift
//  WeatherApp
//
//  Created by Gagandeep on 19/02/24.
//

import Combine
import NetworkServices
import Logging

/// Observable ViewModel weather forecast.
class CurrentWeatherViewModel: ObservableObject {
    @Published var currentWeather: CurrentWeatherModel?
    @Published var downloadState: WeatherDataDownloadState = .notStarted

    private var currentLocationCancellable: Cancellable?
    private let locationManager: LocationProtocol
    private let repo: CurrentWeatherProtocol
    
    init(
        repo: CurrentWeatherProtocol,
        locationManager: LocationProtocol = LocationManager()
    ) {
        self.repo = repo
        self.locationManager = locationManager
    }
    
    /// Method fetched current weather data. If there is some old data then same is returned.
    func getWeatherData() {
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
                case .PermissionRequired:
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
            self.fetchCurrentWeather(coordinate: value)
        }
    }
    
    func reset() {
        downloadState = .notStarted
        currentWeather = nil
    }

    private func fetchCurrentWeather(coordinate: LocationModel) {
        Task {
            do {
                let result = try await repo.getCurrentWeather(coord: coordinate)
                switch result {
                case .success(let model):
                    Log.debug("Successfully got current weather data \(model)")
                    DispatchQueue.main.async {
                        self.downloadState = .finished
                        self.currentWeather = model
                    }
                case .failure(_):
                    // TODO: seperate out different service errors and show specific message.
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
