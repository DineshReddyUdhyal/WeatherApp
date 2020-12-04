//
//  ViewControllerExtensions.swift
//  WeatherApp
//
//  Created by K12 Techno Services Dinesh on 01/12/20.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK:- Alert with completion handler
    func showAlertOnWindow(title: String? = nil, message: String? = nil, titles: [String] = ["OK"], completionHanlder: ((_ title: String) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title ?? "", message: message, preferredStyle: UIAlertController.Style.alert)
        for title in titles {
            alert.addAction(UIAlertAction(title: title, style: UIAlertAction.Style.default, handler: { (action) in
                completionHanlder?(title)
            }))
        }
        present(alert, animated: true, completion: nil)
    }
}
