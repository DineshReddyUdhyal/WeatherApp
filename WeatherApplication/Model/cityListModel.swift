//
//  CityModel.swift
//  WeatherApp
//
//  Created by K12 Techno Services Dinesh on 03/12/20.
//

import Foundation

struct cityListModel {
    var id: Int?
    var name: String?
    var state: String?
    var country : String?
    var coord : coordModel?
    
    public init?(json: JSON) {
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
        self.state = json["state"] as? String
        self.country = json["country"] as? String
        self.coord = json["coord"] as? coordModel
    }
}

struct coordModel {
    var lon : Double?
    var lat :  Double?
    public init?(json: JSON) {
        self.lon = json["lon"] as? Double
        self.lat = json["lat"] as? Double
    }
}
