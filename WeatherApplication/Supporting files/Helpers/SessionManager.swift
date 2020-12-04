//
//  SessionManager.swift
//  WeatherApp
//
//  Created by K12 Techno Services Dinesh on 01/12/20.
//

import UIKit
import Foundation

class SessionManager {
    
    static func updateRootVC(){
        
        let status = UserDefaults.standard.bool(forKey: sessionKey.loggedInStatus)
        
        var rootVC : UIViewController?
        
        if(status == true){
            rootVC = homeSB.instantiateViewController(withIdentifier: "HomeVC")
        }else{
            rootVC = mainSB.instantiateViewController(withIdentifier: "LoginVC")
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    static func logoutUser() {
        UserDefaults.standard.set(false, forKey: sessionKey.loggedInStatus)
        SessionManager.updateRootVC()

    }
}
