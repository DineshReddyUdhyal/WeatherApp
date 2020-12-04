//
//  WeatherListModel.swift
//  WeatherApplication
//
//  Created by K12 Techno Services Dinesh on 04/12/20.
//

import Foundation

struct WeatherListModel : Codable {
    let lat : Double?
    let lon : Double?
    let timezone : String?
    let timezone_offset : Int?
    let current : WeatherListModelCurrent?
    let minutely : [WeatherListModelMinutely]?
    let hourly : [WeatherListModelHourly]?

    enum CodingKeys: String, CodingKey {

        case lat = "lat"
        case lon = "lon"
        case timezone = "timezone"
        case timezone_offset = "timezone_offset"
        case current = "current"
        case minutely = "minutely"
        case hourly = "hourly"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lon = try values.decodeIfPresent(Double.self, forKey: .lon)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
        timezone_offset = try values.decodeIfPresent(Int.self, forKey: .timezone_offset)
        current = try values.decodeIfPresent(WeatherListModelCurrent.self, forKey: .current)
        minutely = try values.decodeIfPresent([WeatherListModelMinutely].self, forKey: .minutely)
        hourly = try values.decodeIfPresent([WeatherListModelHourly].self, forKey: .hourly)
    }

}
struct WeatherListModelCurrent : Codable {
    let dt : Int?
    let sunrise : Int?
    let sunset : Int?
    let temp : Double?
    let feels_like : Double?
    let pressure : Int?
    let humidity : Int?
    let dew_point : Double?
//    let uvi : Int?
    let clouds : Int?
    let visibility : Int?
    let wind_speed : Double?
    let wind_deg : Int?
    let weather : [WeatherListModelWeather]?

    enum CodingKeys: String, CodingKey {

        case dt = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case temp = "temp"
        case feels_like = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dew_point = "dew_point"
//        case uvi = "uvi"
        case clouds = "clouds"
        case visibility = "visibility"
        case wind_speed = "wind_speed"
        case wind_deg = "wind_deg"
        case weather = "weather"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
        sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
        sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
        feels_like = try values.decodeIfPresent(Double.self, forKey: .feels_like)
        pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        dew_point = try values.decodeIfPresent(Double.self, forKey: .dew_point)
//        uvi = try values.decodeIfPresent(Int.self, forKey: .uvi)
        clouds = try values.decodeIfPresent(Int.self, forKey: .clouds)
        visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
        wind_speed = try values.decodeIfPresent(Double.self, forKey: .wind_speed)
        wind_deg = try values.decodeIfPresent(Int.self, forKey: .wind_deg)
        weather = try values.decodeIfPresent([WeatherListModelWeather].self, forKey: .weather)
    }

}

struct WeatherListModelHourly : Codable {
    let dt : Double?
    let temp : Double?
    let feels_like : Double?
    let pressure : Int?
    let humidity : Int?
    let dew_point : Double?
//    let uvi : Int?
    let clouds : Int?
    let visibility : Int?
    let wind_speed : Double?
    let wind_deg : Int?
    let weather : [WeatherListModelWeather]?
//    let pop : Int?

    enum CodingKeys: String, CodingKey {

        case dt = "dt"
        case temp = "temp"
        case feels_like = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case dew_point = "dew_point"
//        case uvi = "uvi"
        case clouds = "clouds"
        case visibility = "visibility"
        case wind_speed = "wind_speed"
        case wind_deg = "wind_deg"
        case weather = "weather"
//        case pop = "pop"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dt = try values.decodeIfPresent(Double.self, forKey: .dt)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
        feels_like = try values.decodeIfPresent(Double.self, forKey: .feels_like)
        pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        dew_point = try values.decodeIfPresent(Double.self, forKey: .dew_point)
//        uvi = try values.decodeIfPresent(Int.self, forKey: .uvi)
        clouds = try values.decodeIfPresent(Int.self, forKey: .clouds)
        visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
        wind_speed = try values.decodeIfPresent(Double.self, forKey: .wind_speed)
        wind_deg = try values.decodeIfPresent(Int.self, forKey: .wind_deg)
        weather = try values.decodeIfPresent([WeatherListModelWeather].self, forKey: .weather)
//        pop = try values.decodeIfPresent(Int.self, forKey: .pop)
    }

}

struct WeatherListModelMinutely : Codable {
    let dt : Int?
    let precipitation : Int?

    enum CodingKeys: String, CodingKey {

        case dt = "dt"
        case precipitation = "precipitation"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
        precipitation = try values.decodeIfPresent(Int.self, forKey: .precipitation)
    }

}

struct WeatherListModelWeather : Codable {
    let id : Int?
    let main : String?
    let description : String?
    let icon : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }

}
