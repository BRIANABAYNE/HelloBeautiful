//
//  LogInViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/27/23.
//

import UIKit

class LogInViewController: UIViewController {
    
    
    
    @IBOutlet weak var logInEmaiTextField: UITextField!
    @IBOutlet weak var logInPasswordTextField: UITextField!
    
    // MARK: - Properties
    
    var viewModel:LogInViewModel!
   
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LogInViewModel(delegate: self)
    }
    
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        guard let email = logInEmaiTextField.text,
              let password = logInPasswordTextField.text  else { return }
        viewModel.signIn(with: email, password: password)
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
       
        
    }
    
}
extension LogInViewController: LogInViewModelDelegate {
    func encountered(_ error: Error) {
        // present alert
    }
    
    
}
