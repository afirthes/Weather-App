//
//  WeatherManager.swift
//  Weather
//
//  Created by sehio on 01.08.2021.
//

import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherData?)
    
    func didUpdateWeatherGPS(weather: WeatherData?)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=<your api key here>&units=metric"
    
    func fetchWeather(cityName:String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString) { delegate?.didUpdateWeather(weather: $0) }
    }
    
    func fetchWeather(lat: Double?, lon: Double?) {
        let urlString = "\(weatherURL)&lat=\(String(format: "%f", lat ?? 0.0))&lon=\(String(format: "%f", lon ?? 0.0))"
        print("Requesting: \(urlString)")
        performRequest(urlString: urlString) { delegate?.didUpdateWeatherGPS(weather: $0) }
    }
      
    func performRequest(urlString: String, notify: @escaping (WeatherData?)->Void ) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: {
                data, response, error in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let weather = self.parseJSON(weatherData: safeData)
                    notify(weather)
                }
            })
            // Start task (starts from suspended state)
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print("\(decodedData.weather[0].description)")
            print("\(decodedData.main.temp)")
            return decodedData
        } catch {
            print(error)
        }
        return nil
    }
    
}
