//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Yao Yu on 3/13/20.
//  Copyright © 2020 Yao Yu. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty
        {
            let alert = UIAlertController(title: "Info Required!", message: "Please fill out username and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else {
            let newUser = PFUser()
               
               // set user properties
               newUser.username = usernameTextField.text
               newUser.password = passwordTextField.text
               
               // call sign up function on the object
               newUser.signUpInBackground { (success: Bool, error: Error?) in
                   if let error = error {
                       print(error.localizedDescription)
                   } else {
                        print("User Registered successfully")
                        self.usernameTextField.text = nil
                        self.passwordTextField.text = nil
                        self.performSegue(withIdentifier: "loginSegue", sender: nil)
                   }
               }
        }
    }
    
    @IBAction func login(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
             if let error = error {
               print("User log in failed: \(error.localizedDescription)")
             } else {
               print("User logged in successfully")
                self.usernameTextField.text = nil
                self.passwordTextField.text = nil
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
               // display view controller that needs to shown after successful login
             }
          }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
