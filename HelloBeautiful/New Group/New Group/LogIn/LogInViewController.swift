//
//  LogInViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/27/23.
//

import UIKit

class LogInViewController: UIViewController {

   
  
    @IBOutlet weak var logInEmailLabel: UITextField!
    @IBOutlet weak var logInPasswordLabel: UITextField!
    @IBOutlet weak var logInConfirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        guard let email = logInEmailLabel.text,
              let password = logInPasswordLabel.text,
              let confirmPassword = logInConfirmPassword.text else { return }
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
