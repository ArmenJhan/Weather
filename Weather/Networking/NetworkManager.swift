//
//  Weather.swift
//  Weather
//
//  Created by Armen Madoyan on 22.02.2023.
//

import UIKit

protocol NetworkManagerDelegate {
    func didUpdateWeather(_ networkManager: NetworkManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct NetworkManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c0716d5aa2a9f05638d8f882a0eeef21&units=metric"
    var delegate: NetworkManagerDelegate?
    
    func fetchWeather( cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, rasponse, error in
            if error != nil {
                delegate?.didFailWithError(error: error!)
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            if let safeData = data {
                if let weather = self.parseJSON(safeData) {
                    delegate?.didUpdateWeather(self, weather: weather)
                }
            }
        }.resume()
    }
    
    func parseJSON(_ weatherDate: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(WeatherData.self, from: weatherDate)
            let id = weather.weather[0].id
            let description = weather.weather.description
            let temp = weather.main.temp
            let name = weather.name
            
            let weatherModel = WeatherModel(conditionId: id, description: description, cityName: name, temperature: temp)
            
            return weatherModel
        } catch {
            delegate?.didFailWithError(error: error)
            print(error.localizedDescription )
            return nil
        }
    }
}
