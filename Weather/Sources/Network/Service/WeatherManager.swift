//
//  WeatherManager.swift
//  Weather
//
//  Created by Michel Jaejin Kim on 21/07/23.
//

import Foundation

class WeatherManager {
    
    let key = "ffd010af452f640e24a48b91419dd9fe"
    let unit = "metric"
    let lang = "pt-br"
    
    let latitude = -23.5505
    let longitude = -46.6333
    
    func fetchData(completion: @escaping (WeatherModel?, String?) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?appid=\(key)&units=\(unit)&lang=\(lang)&lat=\(latitude)&lon=\(longitude)"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let data {
                do {
                    let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
                    
                    let id = decodedData.weather[0].id
                    let temp = decodedData.main.temp
                    let name = decodedData.name
                    
                    let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
                    
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
