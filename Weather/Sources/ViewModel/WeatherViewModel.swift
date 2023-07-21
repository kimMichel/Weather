//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Michel Jaejin Kim on 21/07/23.
//

import Foundation
import CoreLocation

class WeatherViewModel {
    
    var service = WeatherManager()
    
    func getWeather(lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping (WeatherModel) -> Void) {
        
        service.fetchData(lat: lat, lon: lon) { weather, error in
            if let weather = weather {
                completion(weather)
            }
        }
    }
}
