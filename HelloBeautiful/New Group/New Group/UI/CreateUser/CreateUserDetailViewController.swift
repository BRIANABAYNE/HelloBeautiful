//
//  CreateUserDetailViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/26/23.
//

import UIKit

class CreateUserDetailViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var periodLengthTextField: UITextField!
    @IBOutlet weak var sunSignPicker: UIPickerView!
    
    // MARK: -  Properties
    let data = ["Aries","Taurus","Gemini","Cancer","Leo","Virgo","Libra","Scorpio","Sagittarius","Capicorn","Aquarius","Pisces"]
    
    var user: User?
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sunSignPicker.dataSource = self
        sunSignPicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func cancelButtonTapped(_ sender: Any) {
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
    }
    

  // MARK: - Methods
    private func configureView() {
        guard let user = user else { return }
        firstNameTextField.text = user.firstName
        lastNameTextField.text = user.lastName
        emailTextField.text = user.email
        passwordTextField.text = user.password
        periodLengthTextField.text = user.lastCycle
    }
    
    // MARK: - Extension

}
extension CreateUserDetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }

}

extension CreateUserDetailViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
}
