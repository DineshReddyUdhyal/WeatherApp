//
//  SplashVC.swift
//  WeatherApplication
//
//  Created by K12 Techno Services Dinesh on 04/12/20.
//

import UIKit

class SplashVC: UIViewController {

    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 1.0, delay: 1.0, options: .curveEaseOut, animations: {
            self.bgImage.alpha = 0.0
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                
                if UserDefaults.standard.bool(forKey: sessionKey.loggedInStatus) == true{
                    let vc = homeSB.instantiateViewController(withIdentifier: "HomeVC")
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let vc = mainSB.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                
            }
        }, completion: nil)

        // Do any additional setup after loading the view.
    }
    
}
