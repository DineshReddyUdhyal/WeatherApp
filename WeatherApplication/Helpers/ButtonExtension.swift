//
//  ButtonExtension.swift
//  WeatherApp
//
//  Created by K12 Techno Services Dinesh on 01/12/20.
//

import Foundation
import UIKit

extension UIButton {
    func appMainButtonStyle() {
        self.layer.cornerRadius = 8
        self.backgroundColor = #colorLiteral(red: 0.3764705882, green: 0.3019607843, blue: 0.6392156863, alpha: 1)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.setTitleColor(UIColor.white, for: [])
    }
}
