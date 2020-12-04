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
            print("Called")
            rootVC = homeSB.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        }else{
            rootVC = mainSB.instantiateViewController(withIdentifier: "SplashVC") as! SplashVC
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = rootVC
        
    }
    static func logoutUser() {
        UserDefaults.standard.set(false, forKey: sessionKey.loggedInStatus)
        SessionManager.updateRootVC()

    }
}
