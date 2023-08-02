//
//  CreateUserDetailViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/26/23.

import UIKit

class CreateUserDetailViewController: UIViewController, CreateUserViewModelDelegate {
    func encountered(_ error: Error) {
        //
    }

    // MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    // MARK: -  Properties
 
    var viewModel:CreateUserViewModel!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateUserViewModel(delegate: self)
    }
    
    // MARK: - Actions
    
    // auth result error in
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,!email.isEmpty,
              let password = passwordTextField.text,!password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text,!confirmPassword.isEmpty else { return }
        viewModel.createAccount(with: email, password: password, confirmPassword: confirmPassword)
    }

}

