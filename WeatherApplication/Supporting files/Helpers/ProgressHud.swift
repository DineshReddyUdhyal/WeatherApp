//
//  ProgressHud.swift
//  WeatherApp
//
//  Created by K12 Techno Services Dinesh on 04/12/20.
//

import Foundation
import UIKit
class ProgressHud {
    
//    static let sharedProgessHud = ProgressHud()
    
   static var container: UIView = UIView()
   static var loadingView: UIView = UIView()
   static var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static var loadingImage : UIImageView = UIImageView()
    
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param uiView - add activity indicator to this view
     */
   static func showActivityIndicator(uiView: UIView) {
    container.frame = uiView.frame
    container.center = uiView.center
    //container.backgroundColor = HexColor("#333333", alpha: 0.3)
    container.backgroundColor = UIColor(red:0.20, green:0.20, blue:0.20, alpha:0.3)
    loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    loadingView.center = uiView.center
    //loadingView.backgroundColor = HexColor("#444444", alpha: 0.7)
    loadingView.backgroundColor = .white//UIColor(red:0.27, green:0.27, blue:0.27, alpha:1.0)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    
    activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
    activityIndicator.style = UIActivityIndicatorView.Style.large
    activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
    
    
    
    loadingView.addSubview(activityIndicator)
    container.addSubview(loadingView)
    uiView.addSubview(container)
    activityIndicator.startAnimating()
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param uiView - remove activity indicator from this view
     */
   static func hideActivityIndicator(uiView: UIView) {
    activityIndicator.stopAnimating()
    container.removeFromSuperview()
    }
    
    static func roatateImageView(){
//        UIView.animate(withDuration: 2,delay: 0,options: .curveLinear, animations: () -> Void) {
//
//            self.loadingImage.transform = self.loadingImage.transform.rotated(by: 10 / 2)
//
//        }
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {() in
            self.loadingImage.transform = self.loadingImage.transform.rotated(by: CGFloat(Double.pi / 2))
        },completion: {(completed) in
            if completed {
                self.roatateImageView()
            }
        })
        
    }
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    //    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
    //        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    //        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    //        let blue = CGFloat(rgbValue & 0xFF)/256.0
    //        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    //    }
    
}


