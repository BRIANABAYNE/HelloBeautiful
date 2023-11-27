//
//  CreateUserDetailViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/26/23.

import UIKit

class CreateUserDetailViewController: UIViewController, AlertPresentable {
    
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
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard
            let email = emailTextField.text,!email.isEmpty,
            let password = passwordTextField.text,!password.isEmpty,
            let confirmPassword = confirmPasswordTextField.text,!confirmPassword.isEmpty
        else { return }
        viewModel.newUserContainer.email = email
        viewModel.newUserContainer.password = password
        navigateToNextScreen(with: viewModel.newUserContainer)
    }
    
    private func navigateToNextScreen(with newUser: NewUser) {
        let storyboard = UIStoryboard(name:"UserDetails", bundle: nil)
        let viewController = UserDetailsViewController.create(with: newUser)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Extension
extension CreateUserDetailViewController: CreateUserViewModelDelegate {
    func encountered(_ error: Error) {
        presentAlert(message: error.localizedDescription, title: "Oh no!")
    }
}
