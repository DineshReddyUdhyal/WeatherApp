//
//  Constants.swift
//  WeatherApp
//
//  Created by K12 Techno Services Dinesh on 01/12/20.
//

import Foundation
/*USER ENTERED DETAILS DEFAULTS*/
struct sessionKey {
    static var loggedInStatus = "loggedInStatus"
}

//Google places
let mapsApiKey = "AIzaSyCyzHxqCK6iHyVBVTSFy-_zTzejKbbENjg"

//Weather Api Key
let ApiKey = "bfdd47e37a2153f7da6db5bec92ed268" //https://openweathermap.org/current

let weatherListApiKey = "c03974d9c9317e6c0c3da8fa2201424b"


// Use this print me function to enable print statement when debugging only
func printMe(object: Any) {
    #if DEBUG
        Swift.print(object)
    #endif
}

typealias JSON = [String: AnyObject]
