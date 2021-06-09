//
//  WeatherData.swift
//  WeatherForecast
//
//  Created by admin on 9/6/2564 BE.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let icon: String
}
