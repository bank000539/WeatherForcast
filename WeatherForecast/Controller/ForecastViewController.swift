//
//  fiveDayForecastViewController.swift
//  WeatherForecast
//
//  Created by admin on 9/6/2564 BE.
//

import UIKit

class ForecastViewController: UIViewController, ForcastManagerDelegate {
    
    @IBOutlet weak var fiveDayTable: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var forcastManger = ForcastManager()
    var data = [List]()
    var cityName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forcastManger.delegate = self
        
        fiveDayTable.register(ForcastCell.nib(), forCellReuseIdentifier: ForcastCell.identifier)
        forcastManger.callForcast(city: cityName)
    }
    
}

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.count == 0 {
            tableView.reloadData()
        }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForcastCell.identifier, for: indexPath) as! ForcastCell
        cell.dateLabel.text = data[indexPath.row].dt_txt
        cell.weatherImage.image = UIImage(named: data[indexPath.row].weather[0].icon)
        cell.weatherDes.text = data[indexPath.row].weather[0].main
        cell.tempLabel.text = String(data[indexPath.row].main.temp) + " °C"
        return cell
    }
    
    func didUpdateForcast(_ weatherManger: ForcastManager, weather: ForcastModel){
        DispatchQueue.main.async {
            self.cityNameLabel.text = weather.cityName
        }
        data = weather.data
    }
    
    func didFail(error: Error) {
        print(error)
    }
    
}
