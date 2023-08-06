//
//  LogInViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/27/23.
//

import UIKit

class LogInViewController: UIViewController {
    
    //MARk: - Outlets
    @IBOutlet weak var logInEmaiTextField: UITextField!
    @IBOutlet weak var logInPasswordTextField: UITextField!
    
    // MARK: - Properties
    var viewModel:LogInViewModel!
   
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LogInViewModel(delegate: self)
    }
    
    // MARK: - Actions
    @IBAction func logInButtonTapped(_ sender: Any) {
        guard let email = logInEmaiTextField.text,
              let password = logInPasswordTextField.text  else { return }
        viewModel.signIn(with: email, password: password)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logIn = storyboard.instantiateViewController(identifier:"tabBar")
        self.view.window?.rootViewController = logIn
        
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
       //TODO: - FINISH THIS
        
    }
    
}

// MARK: Extensions
extension LogInViewController: LogInViewModelDelegate {
    func encountered(_ error: Error) {
        // TODO: - Present Alert
    }
}
