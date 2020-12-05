# WeatherApp

## Our Goal 
    To create a weather application in iOS. To present weather report based on the inputs given by the user.
    We are presenting data with temperature, humidity and weather.
    
## Architecture used
* MVVM architecture

## Model
* Used Codeble models and JSONDecoder to decode json

## Login Screen
    * Has Facebook login from developer.facebook.com
    * Local Authauntication
    * E-Mail Login 

## HomeVC
    * Used CityList (Local JSON file) to get city list
    * Used Weather App Api to fetch weather based on City name

## Weather VC
    * Used weather app to show list of hourly weather

## Reusable Code
    * String extension which has validation for email
    * View controller extensions which has Alert messages and to hide keyboard when tapped around
    * Storboard extensions for storyboard names
    * Session manager to maintain session of user 
    * Button extension to setup button style
    * Constants has api keys for weather api
    * UITableViewCell Extensions to reduce nib register code
    * Progress Hud to show custom loader
    * UIview extensions for shadow and gradient colors 
    
 ## Third parties
    * Facebook sdk for facebook login  
    * lottie-ios to display annimation via JSON files
    * Charts for displaying graph of weather
