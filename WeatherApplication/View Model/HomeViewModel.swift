//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by K12 Techno Services Dinesh on 01/12/20.
//

import UIKit

class HomeViewModel: NSObject {
    var cityWeather : WeatherModel? = nil
    var errorMessage = String()
    
    func getWeatherOfCity(city_name: String,completion: (() -> Void)?){
        
        let SET_URL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city_name)&appid=\(ApiKey)")
        var urlRequest = URLRequest(url: SET_URL!)
        urlRequest.httpMethod = "GET"

        print("SET_URL = \(SET_URL?.description ?? "")")
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
            // status code
            if let errorCode = urlResponse as? HTTPURLResponse{
                if errorCode.statusCode == 404 {
                    let errorData = try! JSONDecoder().decode(CommonErrorModel.self, from: data!)
                    self.errorMessage = errorData.message ?? ""
                    completion?()
                }else{
                    if let err = error {
                        self.errorMessage = err.localizedDescription
                        return
                    } else {
                        guard let data = data else {
                            print("\n*** json sad\n")
                            return
                        }
                        let weatherData = try! JSONDecoder().decode(WeatherModel.self, from: data)
                        self.cityWeather = weatherData
                        self.errorMessage = ""
                        completion?()
                    }
                }
            }
            
            
        }
        
        urlSession.resume()
        

        
    }
    
}
