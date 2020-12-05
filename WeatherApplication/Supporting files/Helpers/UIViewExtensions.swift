//
//  UIViewExtensions.swift
//  WeatherApplication
//
//  Created by K12 Techno Services Dinesh on 05/12/20.
//

import Foundation
import UIKit

extension UIView{
    func applyDefaultShadowWithRadius() {
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 5.0
        self.layer.cornerRadius = 8
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.layer.masksToBounds = false
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
//        let colorTop =  UIColor(red:0.87, green:0.25, blue:0.30, alpha:1.0)
//        let colorBottom = UIColor(red:0.95, green:0.37, blue:0.34, alpha:0.6)

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.clipsToBounds = true

        self.layer.insertSublayer(gradientLayer, at: 0)

        }
}


