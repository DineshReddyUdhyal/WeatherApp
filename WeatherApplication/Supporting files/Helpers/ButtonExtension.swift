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
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6145741637)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.setTitleColor(UIColor.black, for: [])
    }
}
