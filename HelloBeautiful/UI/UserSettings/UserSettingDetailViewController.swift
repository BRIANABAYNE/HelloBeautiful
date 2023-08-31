//
//  UserSettingDetailViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/1/23.
//

import UIKit

class UserSettingDetailViewController: UIViewController, UserSettingsViewModelDelegate {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var zodiacSignLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userCycleLength: UILabel!
    @IBOutlet weak var userPeriodLength: UILabel!
    
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
        self.zodiacSignLabel.text = userDetails.zodiacSign
        self.userEmailLabel.text = user.email
        self.userCycleLength.text = userDetails.cycleLength
        self.userPeriodLength.text = userDetails.lastCycle
        
    }
}
