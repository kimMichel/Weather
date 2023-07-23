//
//  WeatherManager.swift
//  Weather
//
//  Created by Michel Jaejin Kim on 21/07/23.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    let key = "ffd010af452f640e24a48b91419dd9fe"
    let unit = "metric"
    let lang = "pt_br"
    
    func fetchData(lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping (WeatherModel?, String?) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?appid=\(key)&units=\(unit)&lang=\(lang)&lat=\(lat)&lon=\(lon)"
        
        performRequest(urlString: urlString) { weather, error in
            completion(weather, error)
        }
    }
    
    func fetchData(cityName: String, completion: @escaping (WeatherModel?, String?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?appid=\(key)&units=\(unit)&lang=\(lang)&q=\(cityName)"
        
        performRequest(urlString: urlString) { weather, error in
            completion(weather, error)
        }
    }
    
    func performRequest(urlString: String, completion: @escaping (WeatherModel?, String?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let data {
                do {
                    let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
                    
                    let id = decodedData.weather[0].id
                    let temp = decodedData.main.temp
                    let name = decodedData.name
                    let description = decodedData.weather[0].description
                    let minTemp = decodedData.main.temp_min
                    let maxTemp = decodedData.main.temp_max
                    let tempFeelsLike = decodedData.main.feels_like
                    
                    let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: description, minTemp: minTemp, maxTemp: maxTemp, feelsLike: tempFeelsLike)
                    
                    completion(weather, nil)
                } catch {
                    completion(nil, error.localizedDescription)
                }
                
            } else {
                completion(nil, error?.localizedDescription)
            }
        }
        task.resume()
        
    }
}

