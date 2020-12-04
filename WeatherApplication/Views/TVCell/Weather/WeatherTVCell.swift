//
//  WeatherTVCell.swift
//  WeatherApplication
//
//  Created by K12 Techno Services Dinesh on 04/12/20.
//

import UIKit
import Lottie

class WeatherTVCell: UITableViewCell {
    
    @IBOutlet weak var weatherView: AnimationView!
    @IBOutlet weak var CityNameLabel: UILabel!
    @IBOutlet weak var tempInfoLabel: UILabel!
    
    var itemData : WeatherListModelHourly? {
        didSet {
            CityNameLabel.text = itemData?.weather?[0].main
            
//            let date = NSDate(timeIntervalSince1970: itemData?.dt ?? 0)
//            tempInfoLabel.text = "Time : \(date.description)"
            
            let date = Date(timeIntervalSince1970: itemData?.dt ?? 0)
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                dateFormatter.timeZone = .current
                let localDate = dateFormatter.string(from: date)
            tempInfoLabel.text = "Time : \(localDate)"
            
            if itemData?.weather?[0].main == "Clouds" {
                CallLottie(jsonFile: "cloudy")
            } else if itemData?.weather?[0].main == "Clear" {
                CallLottie(jsonFile: "sunny")
            } else if itemData?.weather?[0].main == "Rain" {
                CallLottie(jsonFile: "rainy")
            } else {
                CallLottie(jsonFile: "sunny")
            }
        }
    }
    fileprivate func CallLottie(jsonFile: String) {
        let path = Bundle.main.path(forResource: jsonFile,
                                    ofType: "json") ?? ""
        weatherView.animation = Animation.filepath(path)
        weatherView!.contentMode = .scaleAspectFit
        weatherView!.loopMode = .loop
        weatherView!.animationSpeed = 0.5
        weatherView!.play()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
