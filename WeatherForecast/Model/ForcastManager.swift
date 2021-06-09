//
//  ForcastManager.swift
//  WeatherForecast
//
//  Created by admin on 9/6/2564 BE.
//

import Foundation

protocol ForcastManagerDelegate {
    func didUpdateForcast(_ weatherManger: ForcastManager, weather: ForcastModel)
    func didFail(error: Error)
}

struct ForcastManager {
    let fiveDayWeatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=d02a49012f4596547a963c2da1f1cefa&units=metric&q="
    
    var delegate: ForcastManagerDelegate?
    
    mutating func callForcast(city: String) {
        let urlString = "\(fiveDayWeatherURL)\(city)"
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
                    print(safeData)
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateForcast(self, weather: weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> ForcastModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ForcastData.self, from: weatherData)
            let city = decodedData.city.name
            let data = decodedData.list
            
            let weather = ForcastModel(cityName: city, data: data)
            return weather
        }catch {
            delegate?.didFail(error: error)
            return nil
        }
    }
    
}
