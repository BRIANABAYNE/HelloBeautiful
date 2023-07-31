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
    
    
    var viewModel:LogInViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LogInViewModel(delegate: self)
    }
    
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        guard let email = logInEmailLabel.text,
              let password = logInPasswordLabel.text  else { return }
        viewModel.signIn(with: email, password: password)
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
       
        
    }
    
    
    // MARK: - Navigation
    
    //     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //         if segue.identifier == "CreateUser" {
    //             guard let destinationVC = segue.destination as?
    //                    CreateUserDetailViewController else { return }
    //             destinationVC.
    //         }
    //}
}


extension LogInViewController: LogInViewModelDelegate {
    func encountered(_ error: Error) {
        // present alert
    }
    
    
}
