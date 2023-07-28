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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    var viewModel:LogInViewModel!
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        guard let email = logInEmailLabel.text,
              let password = logInPasswordLabel.text,
              viewModel.signIn(with: email, password: password)
        else { return }
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        
       
    }
    
  
     // MARK: - Navigation
   
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "CreateUser" {
             guard let destinationVC = segue.destination as?
                    CreateUserDetailViewController else { return }
             destinationVC.
         }
}
