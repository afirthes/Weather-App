//
//  ViewController.swift
//  Weather
//
//  Created by sehio on 01.08.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController  {
    
    var manager = WeatherManager()
    
    let locationManager = CLLocationManager()
    
    var lat:Double?
    var lon:Double?

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    
    @IBOutlet weak var gpsTemp: UILabel!
    @IBOutlet weak var gpsCondition: UILabel!
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        updateTempLabel()
    }
    
    @IBAction func refreshCoordinates(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

        searchTextField.delegate = self
        manager.delegate = self
    }
    
    func updateTempLabel() {
        if let city = searchTextField.text {
            manager.fetchWeather(cityName: city)
        }
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateTempLabel()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            let latStr = String(format: "%.6f", lat)
            let lonStr = String(format: "%.6f", lon)
            
            DispatchQueue.main.async {
                self.lonLabel.text = lonStr
                self.latLabel.text = latStr
                
                self.manager.fetchWeather(lat: lat, lon: lon)

            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("GPS error")
    }
}

extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherData?) {
        guard let weather = weather else { return }
        
        DispatchQueue.main.async {
            self.tempLabel.text = String(format: "%.1f", weather.main.temp)
            self.condition.text = weather.weather[0].description
        }
    }
    
    func didUpdateWeatherGPS(weather: WeatherData?) {
        guard let weather = weather else { return }
        
        DispatchQueue.main.async {
            self.gpsTemp.text = String(format: "%.1f", weather.main.temp)
            self.gpsCondition.text = weather.weather[0].description
        }
    }
}
