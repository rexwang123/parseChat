//
//  LoginViewController.swift
//  parseChat
//
//  Created by Jiayi Wang on 2/22/18.
//  Copyright © 2018 Jiayi Wang. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {

   
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var signUpLabel: UIButton!
    @IBOutlet weak var loginLabel: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
    
    @IBAction func loginUser(_ sender: Any) {
        let username = usernameLabel.text ?? ""
        let password = passwordLabel.text ?? ""
        
        if((self.usernameLabel.text?.isEmpty)! || (self.passwordLabel.text?.isEmpty)!){
            let alertController = UIAlertController(title: "Warning", message: "You should fill in username and password", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                // handle cancel response here. Doing nothing will dismiss the view.
            }
            // add the cancel action to the alertController
            alertController.addAction(cancelAction)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            
            
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                   self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            
        }
        
    }
    
    
    
    @IBAction func registerUser(_ sender: Any) {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameLabel.text
        newUser.password = passwordLabel.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
            }
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
