//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Michel Jaejin Kim on 21/07/23.
//

import Foundation

class WeatherViewModel {
    
    var service = WeatherManager()
    
    func getWeather(completion: @escaping (WeatherModel) -> Void) {
        
        service.fetchData { weather, error in
            if let weather = weather {
                completion(weather)
            }
        }
    }
}
