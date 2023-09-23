//
//  UserDetailsViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/28/23.
//

import UIKit


class UserDetailsViewController: UIViewController, UserDetailsViewModelDelegate {
    func encountered(_ error: Error) {
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var lastCycleTextField: UITextField!
    @IBOutlet weak var periodLengthTextField: UITextField!
    @IBOutlet weak var sunSignPicker: UIPickerView!
    
    // MARK: - Properties
    let datePicker = UIDatePicker()
    var viewModel: UserDetailsViewModel!
    var zodiacSignString: String?
    static var completionHandler: ((String?) -> Void)?
    var disclosurePopUP: PopUp!
  
    
    // MARK: - Lifecyles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserDetailsViewModel(injectedDelegate: self)
        sunSignPicker.dataSource = self
        sunSignPicker.delegate = self
        configureLastCycleDatePicker()
       
        
        //        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("text"), object: nil)
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func disclaimerButtonTapped(_ sender: Any) {
        self.disclosurePopUP = PopUp(frame: self.view.frame)
        self.disclosurePopUP.closeButtonTapped.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        self.view.addSubview(disclosurePopUP)
        
    }
    @objc func closeButtonTapped() {
        self.disclosurePopUP.removeFromSuperview()
    }

    
//    @objc func didGetNotification( _ notification: Notification) {
//        let text = notification.object as! String?
//        lastCycleTextField.text = text
//    }
//
    
    
    // MARK: - Functions / Methods
    func configureLastCycleDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
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
    

    // MARK: - Actions
    
    @IBAction func buttonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let navigation = storyboard.instantiateViewController(identifier:"tabBar")
        self.view.window?.rootViewController = navigation
        
        // reading the data
        
        guard let lastCycle = lastCycleTextField.text,
              let zodiacSign = zodiacSignString,
              let cycleLength = periodLengthTextField.text else { return }
        viewModel.saveUser(zodiacSign: zodiacSign, cycleLength: cycleLength, lastCycle: lastCycle)
        
        
//        completionHandler?(field.text)
//        dismiss(animated: true, completion: nil)
        
//        let userSettingStoryboard = UIStoryboard(name:"UserSettings", bundle: nil)
//        
//        
//        let userSettings = userSettingStoryboard.instantiateViewController(identifier:"Settings") as! UserSettingDetailViewController
//        userSettings.modalPresentationStyle = .fullScreen
//        present(userSettings,animated: true)
//        
//        NotificationCenter.default.post(name: Notification.Name("text"), object: periodLengthTextField.text)
//        dismiss(animated: true, completion: nil)
        
        
        }
 
    }// end of VC

// MARK: - Extensions
extension UserDetailsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.data.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        zodiacSignString = viewModel.data[row]
        
    }
    
}
extension UserDetailsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.data[row]
    }
}
