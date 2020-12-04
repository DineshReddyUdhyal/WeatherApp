//
//  TableViewExtensions.swift
//  WeatherApplication
//
//  Created by K12 Techno Services Dinesh on 04/12/20.
//

import Foundation
import UIKit
//MARK:- UITableViewCell Extensions
extension UITableViewCell {
    static var cellId: String {
        return String(describing: self.self)
    }
    
    static var cellNib: UINib {
        return UINib(nibName: cellId, bundle: nil)
    }
}
