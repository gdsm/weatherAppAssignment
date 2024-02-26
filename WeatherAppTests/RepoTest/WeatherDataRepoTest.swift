//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Gagandeep on 20/02/24.
//

import XCTest
@testable import NetworkServices
@testable import WeatherApp

class WeatherDataRepoTest: XCTestCase {
    
    private var config: URLSessionConfiguration!
    private let mockHandlerTag = "WeatherDataRepoTest"
    private static let coords = LocationModel(lat: 28.70, lon: 77.10)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 1
        config.timeoutIntervalForResource = 1
        config.protocolClasses = [MockURLProtocol.self]
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        MockURLProtocol.unregister(tag: mockHandlerTag)
    }
    
    func testGetCurrentWeatherSuccess() {
        let expectation = XCTestExpectation(description: "Async Waiting")
        MockURLProtocol.register(tag: mockHandlerTag) { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: HTTPStatusCode.ok.rawValue,
                httpVersion: "HTTP/1.1",
                headerFields: [:]
            )!
            let data = MockCurrentWeatherRepo.currentWeatherMockData(Self.coords, 300).data(using: .utf8)
            return Result.success((response, data))
        }
        
        let repo = WeatherDataRepo(urlBuilder: URLEnvironment.qa, networkInterface: NetworkService(config: config))
        Task {
            do {
                let result = try await repo.getCurrentWeather(coord: Self.coords)
                switch result {
                case .failure(_):
                    XCTFail("Expecting success")
                case .success(let model):
                    XCTAssertEqual(Self.coords.lat, model.coordinates.lat)
                    XCTAssertEqual(Self.coords.lon, model.coordinates.lon)
                    expectation.fulfill()
                }
            } catch (let exception) {
                XCTFail("Exception in fetching current weather. \(exception)")
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetCurrentWeatherFailure() {
        let expectation = XCTestExpectation(description: "Async Waiting")
        MockURLProtocol.register(tag: mockHandlerTag) { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: HTTPStatusCode.forbidden.rawValue,
                httpVersion: "HTTP/1.1",
                headerFields: [:]
            )!
            return Result.success((response, nil))
        }
        
        let repo = WeatherDataRepo(urlBuilder: URLEnvironment.qa, networkInterface: NetworkService(config: config))
        Task {
            do {
                let result = try await repo.getCurrentWeather(coord: Self.coords)
                switch result {
                case .failure(_):
                    expectation.fulfill()
                case .success(_):
                    XCTFail("Expecting failure")
                }
            } catch (let exception) {
                XCTFail("Exception in fetching current weather. \(exception)")
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherForecastSuccess() {
        let expectation = XCTestExpectation(description: "Async Waiting")
        MockURLProtocol.register(tag: mockHandlerTag) { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: HTTPStatusCode.ok.rawValue,
                httpVersion: "HTTP/1.1",
                headerFields: [:]
            )!
            let data = MockWeatherForecastRepo.weatherForecastMockData(Self.coords).data(using: .utf8)
            return Result.success((response, data))
        }
        
        let repo = WeatherDataRepo(urlBuilder: URLEnvironment.qa, networkInterface: NetworkService(config: config))
        Task {
            do {
                let result = try await repo.getWeatherForecast(coord: Self.coords)
                switch result {
                case .failure(_):
                    XCTFail("Expecting success")
                case .success(let model):
                    XCTAssertEqual(Self.coords.lat, model.city.coordinates.lat)
                    XCTAssertEqual(Self.coords.lon, model.city.coordinates.lon)
                    expectation.fulfill()
                }
            } catch (let exception) {
                XCTFail("Exception in fetching current weather. \(exception)")
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherForecastFailure() {
        let expectation = XCTestExpectation(description: "Async Waiting")
        MockURLProtocol.register(tag: mockHandlerTag) { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: HTTPStatusCode.forbidden.rawValue,
                httpVersion: "HTTP/1.1",
                headerFields: [:]
            )!
            return Result.success((response, nil))
        }
        
        let repo = WeatherDataRepo(urlBuilder: URLEnvironment.qa, networkInterface: NetworkService(config: config))
        Task {
            do {
                let result = try await repo.getWeatherForecast(coord: Self.coords)
                switch result {
                case .failure(_):
                    expectation.fulfill()
                case .success(_):
                    XCTFail("Expecting failure")
                }
            } catch (let exception) {
                XCTFail("Exception in fetching current weather. \(exception)")
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testUrlBuilder() {
        let repo = WeatherDataRepo(urlBuilder: URLEnvironment.qa, networkInterface: NetworkService(config: config))
        let locationModel = LocationModel(lat: 33.0, lon: 34.0)
        
        locationModel.update(state: nil, country: nil)
        var url = repo.buildUrl(coord: locationModel, secondaryUrl: "weather")
        XCTAssertNotNil(url)
        XCTAssertEqual(url!.absoluteString, "https://api.openweathermap.org/data/2.5/weather?lat=33.0&lon=34.0&appid=4f7a815f62f6d72f5d313000a748b8d2")

        locationModel.update(state: "Delhi", country: nil)
        url = repo.buildUrl(coord: locationModel, secondaryUrl: "weather")
        XCTAssertNotNil(url)
        XCTAssertEqual(url!.absoluteString, "https://api.openweathermap.org/data/2.5/weather?q=Delhi&appid=4f7a815f62f6d72f5d313000a748b8d2")

        locationModel.update(state: nil, country: "India")
        url = repo.buildUrl(coord: locationModel, secondaryUrl: "weather")
        XCTAssertNotNil(url)
        XCTAssertEqual(url!.absoluteString, "https://api.openweathermap.org/data/2.5/weather?q=India&appid=4f7a815f62f6d72f5d313000a748b8d2")

        locationModel.update(state: "Delhi", country: "India")
        url = repo.buildUrl(coord: locationModel, secondaryUrl: "weather")
        XCTAssertNotNil(url)
        XCTAssertEqual(url!.absoluteString, "https://api.openweathermap.org/data/2.5/weather?q=Delhi&appid=4f7a815f62f6d72f5d313000a748b8d2")
    }
}
