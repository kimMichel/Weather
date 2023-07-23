//
//  WeatherData.swift
//  Weather
//
//  Created by Michel Jaejin Kim on 21/07/23.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let feels_like: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
