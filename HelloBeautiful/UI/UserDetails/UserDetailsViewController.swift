//
//  UserDetailsViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/28/23.
//

import UIKit
import SwiftUI

class UserDetailsViewController: UIViewController {
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.tintColor = .systemPink
        return datePicker
    }()
    // MARK: - Outlets
    
    @IBOutlet weak var periodLengthTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserDetailsViewModel()
        
        sunSignPicker.dataSource = self
        sunSignPicker.delegate = self
        
        view.addSubview(datePicker)
        datePicker.center = view.center
    }
    // MARK: - Action
    
    @IBOutlet weak var sunSignPicker: UIPickerView!
    
    // When a user hits this button, it saves the information and creats the account. Then the user is directed to the mainstoryboard.
    @IBAction func buttonTapped(_ sender: Any) {
//        var storyboard = UIStoryboard(name:"Main", bundle: nil)
//        var navigation = storyboard.instantiateViewController(identifier:"tabBar")
//        self.viewModel.window.rootViewController = navigation
    }
    
    // MARK: - Properties
    var viewModel: UserDetailsViewModel!

    // MARK: - Navigation

} // end of ViewC

// MARK: - Extension
extension UserDetailsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.data.count
    }
    
}
extension UserDetailsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.data[row]
    }
}
