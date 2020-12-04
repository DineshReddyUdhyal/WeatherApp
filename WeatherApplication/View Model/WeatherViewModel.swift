//
//  WeatherViewModel.swift
//  WeatherApplication
//
//  Created by K12 Techno Services Dinesh on 04/12/20.
//

import UIKit

class WeatherViewModel: NSObject {
    
    var cityWeatherList : WeatherListModel? = nil
    
    func getWeatherOfCity(lat: String,lon: String,completion: (() -> Void)?){
        
        let SET_URL = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=daily&appid=\(weatherListApiKey)")
        var urlRequest = URLRequest(url: SET_URL!)
        urlRequest.httpMethod = "GET"

        print("SET_URL = \(SET_URL?.description ?? "")")
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            // status code
         
            guard let weatherData = try? JSONDecoder().decode(WeatherListModel.self, from: data!) else {
                print("Something went wrong")
                return
            }
            self.cityWeatherList = weatherData
            completion?()
//                let weatherData = try? JSONDecoder().decode(WeatherListModel.self, from: data!)
//                self.cityWeatherList = weatherData
//                completion?()
//
            
        }
        urlSession.resume()
    }
}
