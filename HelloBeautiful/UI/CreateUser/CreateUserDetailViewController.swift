//
//  CreateUserDetailViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/26/23.

import UIKit

class CreateUserDetailViewController: UIViewController, AlertPresentable {
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailTextField: HBTextFieldView!
    @IBOutlet weak var passwordTextField: HBTextFieldView!
    @IBOutlet weak var confirmPasswordTextField: HBTextFieldView!
    
    // MARK: -  Properties
    
    var viewModel:CreateUserViewModel!
    
    // MARK: - Init
    
//    init?(coder: NSCoder) {
//        self.viewModel = CreateUserViewModel()
//        super.init(coder: coder)
//    }
//    
//    @available(*, unavailable, renamed: "init(coder:)")
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateUserViewModel(delegate: self)
        emailTextField.set(placeholder: "Email")
        passwordTextField.set(placeholder: "Password")
        confirmPasswordTextField.set(placeholder: "Confirm Password")
    }
    
    // MARK: - Actions
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard
            let email = emailTextField.text,
            !email.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty,
            let confirmPassword = confirmPasswordTextField.text,
            !confirmPassword.isEmpty
        else { return }
        guard password == confirmPassword else { return }
        
        viewModel.newUserContainer.email = email
        viewModel.newUserContainer.password = password
        navigateToNextScreen(with: viewModel.newUserContainer)
    }
    
    private func navigateToNextScreen(with newUser: NewUser) {
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

extension CreateUserDetailViewController {
    static func create(with viewModel: FeelingsViewModel) -> CreateUserDetailViewController {
        let storyboard = UIStoryboard(name: "CreateUser", bundle: nil)
        return storyboard.instantiateViewController(identifier: "CreateUserDetailViewController") { coder in
            CreateUserDetailViewController(coder: coder)
        }
    }
}
