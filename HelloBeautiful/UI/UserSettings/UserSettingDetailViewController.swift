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
      var text: String?
//    var userEmail: String = ""
//    var text: String = ""
    
    //    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UserSettingsViewModel(delegate: self)
        
        if text != nil {
            userEmailLabel.text = text
        }
//        userEmailLabel?.text = userEmail
    }

    @objc func didGetNotification( _ notification: Notification) {
        let text = notification.object as! String?
//        zodiacSignLabel.text = text
//        userCycleLength.text = text
        userPeriodLength.text = text
    }

    
    // MARK: - Actions
    
    @IBAction func deleteAccountButtonTapped(_ sender: Any) {
      presentDeleteAccountAlert()
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        presentLogOutAlert()
    }
    
    // Helper func
    func changeUI() {
        let storyboard = UIStoryboard(name:"LogIn", bundle: nil)
        let login = storyboard.instantiateViewController(identifier:"LogIn")
        self.view.window?.rootViewController = login
    }
//    NotificationCenter.default.post(name: Notification.Name("text"), object: field.text)
//    dismiss(animated: true, completion: nil)
    
    
    // MARK: - Alert
    
    func presentDeleteAccountAlert() {
        let alertController = UIAlertController(title: "Delete Account?" , message: "Are you sure you want to delete your account? This action cannot be undone!", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Dismiss", style: .default)
        print("Action Taken: Dissmiss") // .default = blue // .destructive = red
        let yesAction = UIAlertAction(title: "Delete Account", style: .destructive) { [self] _ in
            print("Action Taken: Delete List")
            self.viewModel.delete()
            self.changeUI()
            
        }
            alertController.addAction(noAction)
            alertController.addAction(yesAction)
            self.present(alertController, animated: true)
            
        }
    
    func presentLogOutAlert() {
        let alertController = UIAlertController(title: "Log Out?" , message: "Are you sure you want to log out?", preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Dismiss", style: .default)
        print("Action Taken: Dissmiss") // .default = blue // .destructive = red
        let yesAction = UIAlertAction(title: "Log Out", style: .destructive) { [self] _ in
            print("Action Taken: Delete List")
            self.viewModel.signOut()
            self.changeUI()
            
        }
            alertController.addAction(noAction)
            alertController.addAction(yesAction)
            self.present(alertController, animated: true)
        
        }
#warning("You are not calling this func at this time. Think through _when_ you should update the UI with the Users information")
//    func updateUI() {
//              let userDetails = viewModel.userDetails else { return }
//        DispatchQueue.main.async {
//            self.zodiacSignLabel.text = userDetails.zodiacSign
//            self.userEmailLabel.text = user.email
//            self.userCycleLength.text = userDetails.cycleLength
//            self.userPeriodLength.text = userDetails.lastCycle
//
//        }
//    }
    
    

}
