//
//  ForcastData.swift
//  WeatherForecast
//
//  Created by admin on 9/6/2564 BE.
//

import Foundation

struct ForcastData: Codable {
    let list: [List]
    let city: City
    
    init(list: [List],
         city: City){
        self.list = list
        self.city = city
    }
}

struct List: Codable {
    let dt_txt : String
    let weather: [WeatherForcast]
    let main: MainForcast
    
    init(dt_txt: String,
         weather: [WeatherForcast],
         main: MainForcast){
        self.dt_txt = dt_txt
        self.weather = weather
        self.main = main
    }
}

struct MainForcast: Codable {
    let temp: Double
    
    init(temp: Double){
        self.temp = temp
    }
}

struct WeatherForcast: Codable {
    let icon: String
    let main: String
    
    init(icon: String,
         main: String){
        self.icon = icon
        self.main = main
    }
}

struct City: Codable {
    let name : String
    
    init(name: String) {
        self.name = name
    }
}
