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
    static let notificationSendUserDetails = Notification.Name("")
   
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateUserViewModel(delegate: self)
    }
    
    // MARK: - Actions

    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,!email.isEmpty,
              let password = passwordTextField.text,!password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text,!confirmPassword.isEmpty else { return }
        viewModel.createAccount(with: email, password: password, confirmPassword: confirmPassword)
        
        
//        let createUserDetailsVC = CreateUserDetailViewController()
//        createUserDetailsVC.text =

        let createUserDeailsVC = storyboard?.instantiateViewController(identifier: "UserSettingDetailViewController") as! UserSettingDetailViewController
        createUserDeailsVC.text = emailTextField.text
//        let createUserDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserSettingDetailViewController") as! UserSettingDetailViewController
//        createUserDetailViewController.text = emailTextField.text
//        createUserDetailViewController.userEmail = emailTextField.text!
//        createUserDetailViewController.password = passwordTextField.text!
//        self.navigationController?.pushViewController(createUserDetailViewController, animated: true)
        createUserDeailsVC.modalPresentationStyle = .fullScreen
        present(createUserDeailsVC, animated: true, completion: nil)
    }
}


// MARK: - Extension

extension CreateUserDetailViewController: CreateUserViewModelDelegate {
    func encountered(_ error: Error) {
        presentAlert(message: error.localizedDescription, title: "Oh no!")
    }
}
