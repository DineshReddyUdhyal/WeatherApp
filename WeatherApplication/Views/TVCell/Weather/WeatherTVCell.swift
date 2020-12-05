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
    
    @IBOutlet weak var bgView: UIView!
    
    var itemData : WeatherListModelHourly? {
        didSet {
            CityNameLabel.text = itemData?.weather?[0].main
            
//            let date = Date(timeIntervalSince1970: itemData?.dt ?? 0)
//                let dateFormatter = DateFormatter()
//                dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
//                dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
//                dateFormatter.timeZone = .current
//                let localDate = dateFormatter.string(from: date)
//            tempInfoLabel.text = "Time : \(localDate)"
            
            let date = NSDate(timeIntervalSince1970: itemData?.dt ?? 0)

            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"

            let dateString = dayTimePeriodFormatter.string(from: date as Date)
            tempInfoLabel.text = "Time : \(dateString)"

            
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
        weatherView.backgroundColor = .clear
        bgView.setGradientBackground(colorTop: .random(), colorBottom: .random())
        // Initialization code
    }

}
