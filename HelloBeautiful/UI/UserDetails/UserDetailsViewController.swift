//
//  UserDetailsViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/28/23.
//

import UIKit


class UserDetailsViewController: UIViewController {


    // MARK: - Outlets
    @IBOutlet weak var lastCycleTextField: UITextField!
    
    @IBOutlet weak var periodLengthTextField: UITextField!
    
    
    // MARK: - Properties
    
    let datePicker = UIDatePicker()
    var viewModel: UserDetailsViewModel!
    
    
    // MARK: - Lifecyles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserDetailsViewModel()
        
        sunSignPicker.dataSource = self
        sunSignPicker.delegate = self
        lastCycleDatePicker()
        viewModel = UserDetailsViewModel()
//        view.addSubview(datePicker)
//        datePicker.center = view.center
    }
    
    // MARK: - Functions
    
    
    func lastCycleDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
       
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolbar.setItems([doneButton], animated: true)
            lastCycleTextField.inputView = datePicker
            lastCycleTextField.inputAccessoryView = toolbar
            datePicker.locale = .current
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.tintColor = .systemPink
    }
    @objc func doneButtonPressed() {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        lastCycleTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    
    
//    let datePicker: UIDatePicker = {
//        let datePicker = UIDatePicker()
////        let toolbar = UIToolbar()
//        datePicker.inputAccessoryView = toolbar
//            return datePicker
//        }
//
//
//    }()
//
    // MARK: - Action
    
    @IBOutlet weak var sunSignPicker: UIPickerView!
    
    // When a user hits this button, it saves the information and creats the account. Then the user is directed to the mainstoryboard.
    @IBAction func buttonTapped(_ sender: Any) {
    
    let storyboard = UIStoryboard(name:"Main", bundle: nil)
    let navigation = storyboard.instantiateViewController(identifier:"tabBar")
    self.viewModel.window?.rootViewController = navigation
    }

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
