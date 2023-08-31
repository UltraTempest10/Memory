//
//  LoginController.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/25.
//

//import UIKit
//import Parse
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var txtUsernameSignin: UITextField!
//    @IBOutlet weak var txtPasswordSignin: UITextField!
//    @IBOutlet weak var indicatorSignin: UIActivityIndicatorView!
//
//    @IBOutlet weak var txtUsernameSignup: UITextField!
//    @IBOutlet weak var txtPasswordSignup: UITextField!
//    @IBOutlet weak var indicatorSignup: UIActivityIndicatorView!
//
//    @IBOutlet weak var btnLogout: UIButton!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    @IBAction func signin(_ sender: Any) {
//        PFUser.logInWithUsername(inBackground: self.txtUsernameSignin.text!, password: self.txtPasswordSignin.text!) {
//          (user: PFUser?, error: Error?) -> Void in
//          if user != nil {
//            self.displayAlert(withTitle: "Login Successful", message: "")
//          } else {
//            self.displayAlert(withTitle: "Error", message: error!.localizedDescription)
//          }
//        }
//    }
//
//    @IBAction func signup(_ sender: Any) {
//        let user = PFUser()
//        user.username = self.txtUsernameSignup.text
//        user.password = self.txtPasswordSignup.text
//
////        self.indicatorSignup.startAnimating()
//        user.signUpInBackground {(succeeded: Bool, error: Error?) -> Void in
////            self.indicatorSignup.stopAnimating()
//            if let error = error {
//                self.displayAlert(withTitle: "Error", message: error.localizedDescription)
//            } else {
//                self.displayAlert(withTitle: "Success", message: "Account has been successfully created")
//            }
//        }
//    }
//
//    @IBAction func logout(_ sender: Any) {
//        PFUser.logOut()
//    }
//
//    func displayAlert(withTitle title: String, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Ok", style: .default)
//        alert.addAction(okAction)
//        self.present(alert, animated: true)
//    }
//}
import Parse

class LoginController {
    var parseObject = PFObject(className:"UserInfo")
    
    func signin(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    func signup(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let user = PFUser()
        user.username = username
        user.password = password
        
        user.signUpInBackground { (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                completion(false, error)
            } else {
                self.parseObject["username"] = username

                // Saves the new object.
                self.parseObject.saveInBackground {
                  (success: Bool, error: Error?) in
                  if (success) {
                    // The object has been saved.
                  } else {
                    // There was a problem, check error.description
                  }
                }
                completion(true, nil)
            }
        }
    }
    
    func logout() {
        PFUser.logOut()
        memories.posts.removeAll()
    }
}
