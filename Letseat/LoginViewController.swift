//
//  LoginViewController.swift
//  Letseat
//
//  Created by MAC on 26/12/2018.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var TextLogin: UITextField!
    @IBOutlet weak var PassLogin: UITextField!
    @IBOutlet weak var btnLog: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.title = "Login"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: TextLogin.text!, password: PassLogin.text!) { (user, error) in
            if error == nil{
                
                
                self.performSegue(withIdentifier: "loginToHome", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
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
