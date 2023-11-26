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
        
        //        viewModel.createAccount(with: email, password: password, confirmPassword: confirmPassword)
        //
        //
        //                func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //                    guard segue.identifier == "helloBeautiful",
        //                          let destinationVC = segue.destination as? UserDetailsViewController?,
        //                          destinationVC?.email == emailTextField.text,
        //                          destinationVC?.password == passwordTextField.text else {return}
        //
        //
        //                }
        //      /  self.view.window?.rootViewController = navigation
    }
    
    private func navigateToNextScreen(with newUser: NewUser) {
        
//        let storyboard = UIStoryboard(name:"UserDetails", bundle: nil)
        guard let viewController = storyboard?.instantiateViewController(
            identifier: "UserDetailsViewController",
            creator: { coder in
                UserDetailsViewController(newUserContainer: newUser, coder: coder)
                
            }) else {
            fatalError("Failed to create user screen")
        }
        navigationController?.pushViewController(viewController, animated: true)
//        let viewController = UserDetailsViewController(newUserContainer: newUser, coder: coder)
        
    }
}

// MARK: - Extension
extension CreateUserDetailViewController: CreateUserViewModelDelegate {
    func encountered(_ error: Error) {
        presentAlert(message: error.localizedDescription, title: "Oh no!")
    }
}
