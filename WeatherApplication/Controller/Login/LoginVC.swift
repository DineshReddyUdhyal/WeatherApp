//
//  LoginVC.swift
//  WeatherApplication
//
//  Created by K12 Techno Services Dinesh on 04/12/20.
//

import UIKit
import LocalAuthentication

class LoginVC: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnFaceID: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //facboookLogin()
        
        UpdateUI()
        // Do any additional setup after loading the view.
    }
    fileprivate func UpdateUI() {
        errorLabel.text = ""
        errorLabel.textColor = UIColor.systemRed
        
        emailTF.delegate = self
        emailTF.placeholder = "User E-mail"
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: UIResponder.keyboardDidHideNotification, object: nil)
        
        btnLogin.appMainButtonStyle()
        btnFaceID.appMainButtonStyle()
        
        self.hideKeyboardWhenTappedAround() // to hide keyboard when tapped around
    }
    // Note: Below function moves view up when keyboard appears
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else{
            return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: Notification)
    {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        
        if emailTF.text != "" && ((emailTF.text?.validateAsEmail()) != nil)  {
            let vc = homeSB.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            errorLabel.text = "Please fill a valid e-mail"
        }
        
    }
    
    @IBAction func btnTouchID(_ sender: Any) {
        self.authenticateUserTouchID()
    }
    
}
//MARK:- Touch or face id
extension LoginVC{
    func authenticateUserTouchID() {
        let context : LAContext = LAContext()
        // Declare a NSError variable.
        let myLocalizedReasonString = "Authentication is needed to access your Home ViewController."
        var authError: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: myLocalizedReasonString) { success, evaluateError in
                if success // IF TOUCH ID AUTHENTICATION IS SUCCESSFUL, NAVIGATE TO NEXT VIEW CONTROLLER
                {
                    DispatchQueue.main.async{
                        print("Authentication success by the system")
                        let vc = homeSB.instantiateViewController(withIdentifier: "HomeVC")
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                else // IF TOUCH ID AUTHENTICATION IS FAILED, PRINT ERROR MSG
                {
                    if let error = authError {
                        let message = self.showErrorMessageForLAErrorCode(errorCode: error.code)
                        print(message)
                    }
                }
            }
        }
    }
    func showErrorMessageForLAErrorCode( errorCode:Int ) -> String{
        
        var message = ""
        
        switch errorCode {
        
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
            
        }
        
        return message
        
    }
}

extension LoginVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


//MARK:- Face book login
//extension LoginVC {
//    fileprivate func facboookLogin() {
//        if let token = AccessToken.current,
//           !token.isExpired {
//            let token = token.tokenString
//            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
//            request.start { (connection, result, err) in
//
//                guard let Info = result as? [String: Any] else { return }
//                if let userName = Info["name"] as? String
//                {
//                    let vc = homeSB.instantiateViewController(withIdentifier: "HomeVC")
//                    self.navigationController?.pushViewController(vc, animated: false)
//
//                    print("userName \(userName)")
//
//                }
//            }
//        } else {
//            print("Token expired")
//            let loginButton = FBLoginButton()
//            loginButton.center = view.center
//            loginButton.delegate = self
//            loginButton.permissions = ["public_profile", "email"]
//            view.addSubview(loginButton)
//        }
//    }
//}
//extension LoginVC: LoginButtonDelegate {
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        let token = result?.token?.tokenString
//        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
//        request.start { (connection, result, err) in
//            guard let Info = result as? [String: Any] else { return }
//            if let userName = Info["name"] as? String
//            {
//                print(userName)
//            }
//        }
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//
//    }
//}

