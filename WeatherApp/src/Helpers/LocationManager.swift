//
//  LocationHelper.swift
//  WeatherApp
//
//  Created by Gagandeep on 20/02/24.
//

import Foundation
import Combine
import CoreLocation
import Logging
import UIKit

enum LocationError: Error {
    case unknown
    case locationUnavilable
    case permissionRequired
}

protocol LocationProtocol {
    func getCurrentLocation() -> Future<LocationModel, LocationError>
}

///  Object to get device location related queries.
class LocationManager: NSObject, LocationProtocol {
    
    private let locationManager: CLLocationManager
    private var locationCallback: ((LocationModel?) -> Void)?

    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    /// Async method to get current location. Method returns location only once. Method assumes that it has location permission.
    /// - Returns: Current coordinates or error.
    func getCurrentLocation() -> Future<LocationModel, LocationError> {
        // Start requesting locations.
        
        if UIDevice.isSimulator {
            return Future() { [weak self] promise in
                guard let self = self else {
                    Log.error("Instance deallocated.")
                    return
                }
                self.fetchAddressFromCoordinates(coordinates: LocationModel(lat: 28.65, lon: 77.10)) { updatedLocation in
                    promise(Result.success(updatedLocation))
                }
            }
        } else {
            return Future() { [weak self] promise in
                guard let self = self else {
                    Log.error("Instance deallocated.")
                    return
                }
                
                if !self.checkAuthorisationStatus() {
                    promise(Result.failure(.permissionRequired))
                    return
                }
                
                self.locationManager.startUpdatingLocation()
                locationCallback = { coordinates in
                    if let coord = coordinates {
                        self.fetchAddressFromCoordinates(coordinates: coord) { updatedLocation in
                            promise(Result.success(updatedLocation))
                        }
                    } else {
                        promise(Result.failure(.locationUnavilable))
                    }
                }
            }
        }
    }
    
    private func fetchAddressFromCoordinates(
        coordinates: LocationModel,
        completion: @escaping ((LocationModel) -> Void)
    ) {
        let location = CLLocation(latitude: coordinates.lat, longitude: coordinates.lon)
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                Log.warn("Reverse geocoding failed with error: \(error?.localizedDescription ?? "Unknown error")")
                completion(coordinates)
                return
            }
            
            coordinates.update(state: placemark.locality, country: placemark.country)
            completion(coordinates)
        }
    }
    
    private func checkAuthorisationStatus() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse, .restricted:
            return true
        case .denied:
            return false
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            return true
        @unknown default:
            Log.warn("Unknown location status.")
            self.locationManager.requestWhenInUseAuthorization()
            return true
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coord = locations.last?.coordinate else {
            Log.error("Error in fetching current location.")
            self.locationCallback?(nil)
            return
        }
        let coordModel = LocationModel(lat: coord.latitude.magnitude, lon: coord.longitude.magnitude)
        self.locationCallback?(coordModel)
    }
}
