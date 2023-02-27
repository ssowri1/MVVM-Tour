//
//  WeatherStatusTests.swift
//  WeatherStatusTests
//
//  Created by Sowrirajan S on 10/02/23.
//

import XCTest
@testable import WeatherStatus

final class WeatherStatusTests: XCTestCase {

    var viewModel = WeatherViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        initalConfigure()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

 
    func initalConfigure() {
        let main = MainClass(temp: 43, feelsLike: 435, tempMin: 32, tempMax: 43, pressure: 43, seaLevel: 43, grndLevel: 78, humidity: 67, tempKf: 56)
        let weather = Weather(id: 436, main: "Cloud", description: "Very cool", icon: "test")
        let cloud = Clouds(all: 43)
        let wind = Wind(speed: 45, deg: 554, gust: 554)
        let sys = Sys(pod: .d)
        let rain = Rain(the3H: 4343)
        let city = City(id: 4738, name: "India", coord: Coord(lat: 456.22, lon: 434.43), country: "India", population: 4343, timezone: 54, sunrise: 43, sunset: 43)
        viewModel.weatherDetails = WeatherResponseModel(cod: "123", message: 21, cnt: 32, list: [List(dt: 43, main: main, weather: [weather], clouds: cloud, wind: wind, visibility: 43, pop: 54, sys: sys, dtTxt: "12-02-2023", rain: rain)], city: city)
    }
    
    func testWeatherDataTrue() {
        let weatherData = viewModel.featchWeather?.first
        XCTAssertTrue(weatherData?.main == "Cloud")
        XCTAssertTrue(weatherData?.description == "Very cool")
        XCTAssertTrue(weatherData?.id == 436)
        XCTAssertTrue(weatherData?.icon == "test")
    }

    func testWeatherDataNil() {
        viewModel.weatherDetails = nil
        let weatherData = viewModel.featchWeather?.first
        XCTAssertNil(weatherData?.main)
        XCTAssertNil(weatherData?.description)
        XCTAssertNil(weatherData?.id)
        XCTAssertNil(weatherData?.icon)
    }
    
    func testWeatherDataNotNil() {
        let weatherData = viewModel.featchWeather?.first
        XCTAssertNotNil(weatherData?.main)
        XCTAssertNotNil(weatherData?.description)
        XCTAssertNotNil(weatherData?.id)
        XCTAssertNotNil(weatherData?.icon)
    }
    
    func testNumberOfRows() {
        let rows = viewModel.numberOfRows
        XCTAssertFalse(rows == 1)
    }
    
    func testGetWeather() {
        let weather = viewModel.getWeather(IndexPath(row: 0, section: 0))
        XCTAssertFalse(weather?.icon == "Cloud")
        XCTAssertFalse(weather?.description == "Very cool")
        XCTAssertFalse(weather?.area == "436")
        XCTAssertFalse(weather?.locationID == 56)
    }
}
