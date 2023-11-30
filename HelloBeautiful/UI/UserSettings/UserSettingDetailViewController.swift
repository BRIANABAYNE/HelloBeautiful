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
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UserSettingsViewModel(delegate: self)
    }
    
    // MARK: - Actions
    
    @IBAction func deleteAccountButtonTapped(_ sender: Any) {
        presentDeleteAccountAlert()
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        presentLogOutAlert()
    }
    
    // MARK: - Helper Function
    
    func changeUI() {
        let storyboard = UIStoryboard(name:"LogIn", bundle: nil)
        let login = storyboard.instantiateViewController(identifier:"LogIn")
        self.view.window?.rootViewController = login
    }
    
    // MARK: - Alert
    
    func presentDeleteAccountAlert() {
        let alertController = UIAlertController(
            title: "Delete Account?" ,
            message: "Are you sure you want to delete your account? This action cannot be undone!",
            preferredStyle: .alert
        )
        
        let noAction = UIAlertAction(
            title: "Dismiss",
            style: .default)
        print("Action Taken: Dismiss")
        let yesAction = UIAlertAction(
            title: "Delete Account",
            style: .destructive) { [self] _ in
            print("Action Taken: Delete List")
            self.viewModel.delete()
            self.changeUI()
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true)
    }
    
    func presentLogOutAlert() {
        let alertController = UIAlertController(
            title: "Log Out?" ,
            message: "Are you sure you want to log out?",
            preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Dismiss", style: .default)
        print("Action Taken: Dismiss")
        let yesAction = UIAlertAction(
            title: "Log Out", style: .destructive) { [self] _ in
            print("Action Taken: Delete List")
            self.viewModel.signOut()
            self.changeUI()
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true)
    }
}
