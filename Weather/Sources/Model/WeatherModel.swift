//
//  WeatherModel.swift
//  Weather
//
//  Created by Michel Jaejin Kim on 21/07/23.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    let minTemp: Double
    let maxTemp: Double
    let feelsLike: Double
    
    var temperatureString: String {
        return String(format: "%.1f°C", temperature)
    }
    
    var minTempString: String {
        return String(format: "%.1f°C", minTemp)
    }
    
    var maxTempString: String {
        return String(format: "%.1f°C", maxTemp)
    }
    
    var tempFeelsLikeString: String {
        return String(format: "%.1f°C", feelsLike)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
