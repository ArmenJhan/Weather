//
//  WeatherModel.swift
//  Weather
//
//  Created by Armen Madoyan on 22.02.2023.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let description: String
    let cityName: String
    let temperature: Double
    
    var temperatureString : String {
        String(format: "%.1f", temperature)
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
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
}
