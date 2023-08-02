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
        viewModel.delete()
        changeUI()
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        viewModel.signOut()
        changeUI()
    }
    
    // Helper func
    func changeUI() {
        let storyboard = UIStoryboard(name:"LogIn", bundle: nil)
        let login = storyboard.instantiateViewController(identifier:"LogIn")
        self.view.window?.rootViewController = login
    }
    
    #warning("You are not calling this func at this time. Think through _when_ you should update the UI with the Users information")
    func updateUI() {
        guard let user = viewModel.user,
              let userDetails = viewModel.userDetails else { return }
        self.zodiacSignTextField.text = userDetails.zodiacSign
        self.userEmailTextField.text = user.email
        self.cycleLengthTextField.text = userDetails.cycleLength
        self.periodLengthTextField.text = userDetails.lastCycle
        
    }
}
