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
    
    var showLoading: (() -> Void)?
    
    func getWeather(lat: CLLocationDegrees, lon: CLLocationDegrees, completion: @escaping (WeatherModel) -> Void) {
        
        showLoading?()
        
        service.fetchData(lat: lat, lon: lon) { weather, error in
            if let weather = weather {
                completion(weather)
            } else {
                print(error ?? "Error: fetching data with current location.")
            }
        }
    }
    
    func getWeather(cityName: String, completion: @escaping (WeatherModel) -> Void) {
        service.fetchData(cityName: cityName) { weather, error in
            if let weather = weather {
                completion(weather)
            } else {
                print(error ?? "Error: fetching data with city name.")
            }
        }
    }
}
