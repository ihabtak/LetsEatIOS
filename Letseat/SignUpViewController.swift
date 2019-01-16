//
//  SignUpViewController.swift
//  Letseat
//
//  Created by MAC on 26/12/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var UserSignUp: UITextField!
    @IBOutlet weak var PassSignUp: UITextField!
    @IBOutlet weak var RePassSignUP: UITextField!
    @IBOutlet weak var BtnSign: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign-up"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnSignUp(_ sender: UIButton) {
        if PassSignUp.text != RePassSignUP.text {
            
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
            
        else{
            
            Auth.auth().createUser(withEmail: UserSignUp.text!, password: PassSignUp.text!){ (user, error) in
                
                if error == nil {
                    
                    self.performSegue(withIdentifier: "signupToHome", sender: self)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
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
