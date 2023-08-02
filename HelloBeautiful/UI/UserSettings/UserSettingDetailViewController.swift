//
//  UserSettingDetailViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/1/23.
//

import UIKit

class UserSettingDetailViewController: UIViewController, UserSettingsViewModelDelegate {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var zodiacSignTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var cycleLengthTextField: UITextField!
    @IBOutlet weak var periodLengthTextField: UITextField!
    
    // MARK: - Properties
    
    var viewModel: UserSettingsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UserSettingsViewModel(delegate: self)
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func deleteAccountButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        
        viewModel.signOut()
        let storyboard = UIStoryboard(name:"LogIn", bundle: nil)
        let login = storyboard.instantiateViewController(identifier:"LogIn")
        self.view.window?.rootViewController = login
    }
    
    func updateUI() {
        guard let user = viewModel.user,
              let userDetails = viewModel.userDetails else { return }
        self.zodiacSignTextField.text = userDetails.zodiacSign
        self.userEmailTextField.text = user.email
        self.cycleLengthTextField.text = userDetails.cycleLength
        self.periodLengthTextField.text = userDetails.lastCycle
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
