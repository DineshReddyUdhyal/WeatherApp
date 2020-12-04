//
//  CityManager.swift
//  WeatherApp
//
//  Created by K12 Techno Services Dinesh on 03/12/20.
//

import UIKit

class CityManager: NSObject {
        
        static let sharedInstance = CityManager()
        
        func getCityListResponse(onSuccess: @escaping([Any]?) -> ())
        {
            do {
                if let file = Bundle.main.url(forResource: "CityList", withExtension: "json") {
                    let data = try Data(contentsOf: file)
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let object = json as? [String: Any] {
                        // json is a dictionary
                        let projectResult = object["city_list"] as! NSArray
                        print(object)
                        onSuccess(projectResult as? [Any])
                        
                    } else if let object = json as? [Any] {
                        // json is an array
                        print(object)
                        onSuccess(object)
                    } else {
                        print("JSON is invalid")
                    }
                } else {
                    print("no file")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    
}
