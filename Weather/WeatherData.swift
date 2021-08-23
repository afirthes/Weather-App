//
//  WeatherData.swift
//  Weather
//
//  Created by sehio on 01.08.2021.
//

import UIKit

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
   let description: String
}

struct WeatherData: Decodable {
    
    let main: Main
    let name: String
    let weather: [Weather]
    
}
    /*
     {
         "coord": {
             "lon": 37.6156,
             "lat": 55.7522
         },
         "weather": [
             {
                 "id": 501,
                 "main": "Rain",
                 "description": "moderate rain",
                 "icon": "10d"
             }
         ],
         "base": "stations",
         "main": {
             "temp": 23.95,
             "feels_like": 24.23,
             "temp_min": 22.29,
             "temp_max": 25.15,
             "pressure": 1011,
             "humidity": 70,
             "sea_level": 1011,
             "grnd_level": 994
         },
         "visibility": 10000,
         "wind": {
             "speed": 3.2,
             "deg": 296,
             "gust": 3.58
         },
         "rain": {
             "1h": 1.13
         },
         "clouds": {
             "all": 100
         },
         "dt": 1627813326,
         "sys": {
             "type": 2,
             "id": 2000314,
             "country": "RU",
             "sunrise": 1627781683,
             "sunset": 1627839413
         },
         "timezone": 10800,

         "cod": 200
     }
     */

