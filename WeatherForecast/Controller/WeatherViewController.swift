//
//  ViewController.swift
//  WeatherForecast
//
//  Created by admin on 8/6/2564 BE.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    
    @IBOutlet weak var searchCityTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var convertTempButton: UIButton!
    @IBOutlet weak var noti: UILabel!
    @IBOutlet weak var dataView: UIStackView!
    @IBOutlet weak var forcastButton: UIBarButtonItem!
    
    var weatherManager = WeatherManager()
    var tempUnit = "C"
    var tempC: String?
    var tempF: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        weatherManager.delegate = self
        searchCityTextField.delegate = self
        forcastButton.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let forecastVC = segue.destination as! ForecastViewController
        forecastVC.cityName = searchCityTextField.text!
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        sentCity()
    }
    
    @IBAction func onClickConvertTemp(_ sender: UIButton) {
        if sender.isSelected {
            convertTempButton.setTitle("Convert to °F", for: .normal)
            tempUnit = "C"
            tempLabel.text = "\(tempC!) °C"
        }else{
            convertTempButton.setTitle("Convert to °C", for: .normal)
            tempUnit = "F"
            tempLabel.text = "\(tempF!) °F"
        }
        sender.isSelected = !sender.isSelected
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sentCity()
        return true
    }
    
    func sentCity() {
        if let city = searchCityTextField.text {
            searchCityTextField.endEditing(true)
            weatherManager.callWather(city: city)
        }
    }
    
    func didUpdateWeather(_ weatherManger: WeatherManager, weather: WeatherModel) {
        tempC = weather.tempC
        tempF = weather.tempF
        
        DispatchQueue.main.async {
            self.forcastButton.isEnabled = true
            self.dataView.isHidden = false
            self.noti.isHidden = true
            
            self.cityLabel.text = weather.cityName
            self.weatherImage.image = UIImage(named: weather.imageName)
            self.humidityLabel.text = String(weather.humidity)
            
            if self.tempUnit == "C"{
                self.tempLabel.text = String(weather.tempC) + " °C"
            }else{
                self.tempLabel.text = String(weather.tempF) + " °F"
            }
        }
    }
    
    func didFail(error: Error) {
        DispatchQueue.main.async {
            self.forcastButton.isEnabled = false
            self.dataView.isHidden = true
            self.noti.isHidden = false
            self.noti.text = "Please check name of city"
        }
        
        print(error)
    }
}

