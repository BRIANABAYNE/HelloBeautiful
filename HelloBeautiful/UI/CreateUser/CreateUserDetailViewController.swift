//
//  CreateUserDetailViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/26/23.
//

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
    //    let data = ["Aries","Taurus","Gemini","Cancer","Leo","Virgo","Libra","Scorpio","Sagittarius","Capicorn","Aquarius","Pisces"]
    //
    var user: User?
    var viewModel:CreateUserViewModel!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateUserViewModel(delegate: self)
    
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    
    // auth result error in
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,!email.isEmpty,
              let password = passwordTextField.text,!password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text,!confirmPassword.isEmpty else { return }
        viewModel.createAccount(with: email, password: password, confirmPassword: confirmPassword)
        
    }
    
    
 // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UserDetails" {
            let destinationVC = segue.destination as? UserDetailsViewController
            if let email = emailTextField.text,
               let password = passwordTextField.text,
               let confirmPassword = passwordTextField.text {
                viewModel.createAccount(with: email, password: password, confirmPassword: confirmPassword)
            }
        }
    }
    
    // MARK: - Methods
    //    private func configureView() {
    //        guard let user = user else { return }
    //        firstNameTextField.text = user.firstName
    //        lastNameTextField.text = user.lastName
    //        emailTextField.text = user.email
    //        passwordTextField.text = user.password
    //        periodLengthTextField.text = user.lastCycle
    //    }
    
    // MARK: - Extension
    
    //}
    //extension CreateUserDetailViewController: UIPickerViewDataSource {
    //    func numberOfComponents(in pickerView: UIPickerView) -> Int {
    //       return 1
    //    }
    //
    //    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    //        return data.count
    //    }
    //
    //}
    //
    //extension CreateUserDetailViewController: UIPickerViewDelegate {
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return data[row]
    //    }
    //}
}

