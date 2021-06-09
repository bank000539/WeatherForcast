//
//  WeatherModel.swift
//  WeatherForecast
//
//  Created by admin on 8/6/2564 BE.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManger: WeatherManager, weather: WeatherModel)
    func didFail(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d02a49012f4596547a963c2da1f1cefa&units=metric&q="
    
    var delegate: WeatherManagerDelegate?
    
    func callWather(city: String) {
        let urlString = "\(weatherURL)\(city)"
        requestData(with: urlString)
    }
    
    func requestData(with urlString : String) {
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFail(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let city = decodedData.name
            let temp = decodedData.main.temp
            let humidity = decodedData.main.humidity
            let icon = decodedData.weather[0].icon
            
            let weather = WeatherModel(cityName: city, temperature: temp, humidity: humidity, imageName: icon)
            return weather
        }catch {
            delegate?.didFail(error: error)
            return nil
        }
    }
    
}
