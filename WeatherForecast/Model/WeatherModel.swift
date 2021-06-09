//
//  WeatherModel.swift
//  WeatherForecast
//
//  Created by admin on 9/6/2564 BE.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let temperature: Double
    let humidity: Int
    let imageName: String
    
    var tempC: String{
        return String(format: "%.1f", temperature)
    }
    
    var tempF: String{
        return String(format: "%.1f", (temperature * 9/5) + 32)
    }
}
