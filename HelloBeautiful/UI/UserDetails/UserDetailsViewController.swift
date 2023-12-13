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
    
    @IBOutlet weak var lastCycleTextField: HBTextFieldView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var periodLengthTextField: HBTextFieldView!
    @IBOutlet weak var sunSignPicker: UIPickerView!
    
    // MARK: - Properties
    
    var viewModel: UserDetailsViewModel!
    var zodiacSignString: String?
    static var completionHandler: ((String?) -> Void)?
    var disclosurePopUP: PopUp!
    var email: String = ""
    var password: String = ""
    private let newUserContainer: NewUser
    
    init?(newUserContainer: NewUser, coder: NSCoder) {
        self.newUserContainer = newUserContainer
        super.init(coder: coder)
    }
    
    @available(*, unavailable, renamed: "init(newUserContainer:coder:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserDetailsViewModel(injectedDelegate: self)
        sunSignPicker.dataSource = self
        sunSignPicker.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(newUserContainer)
        lastCycleTextField.makeFirstResponder()
    }
    
    // MARK: - Actions
    
    @IBAction func disclaimerButtonTapped(_ sender: Any) {
        self.disclosurePopUP = PopUp(frame: self.view.frame)
        self.disclosurePopUP.closeButtonTapped.addTarget(self, action: #selector(
            closeButtonTapped), for: .touchUpInside)
        self.view.addSubview(disclosurePopUP)
    }
    
    @objc func closeButtonTapped() {
        self.disclosurePopUP.removeFromSuperview()
    }

    // MARK: - Actions
    
    @IBAction func buttonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let navigation = storyboard.instantiateViewController(identifier:"tabBar")
        self.view.window?.rootViewController = navigation
        
        guard
            let zodiacSign = zodiacSignString,
            let length = periodLengthTextField.text,
            let cycleLength = Int(length)
        else { return }
        viewModel.saveUser(
            zodiacSign: zodiacSign,
            cycleLength: cycleLength,
            lastCycle: datePicker.date,
            email: email,
            password: password)
    }
}

// MARK: - Extensions

extension UserDetailsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
        return viewModel.zodiacSigns.count
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int)
    {
        zodiacSignString = viewModel.zodiacSigns[row]
    }
}
extension UserDetailsViewController: UIPickerViewDelegate {
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int) -> String?
    {
        return viewModel.zodiacSigns[row]
    }
}

extension UserDetailsViewController {
    static func create(with newUser: NewUser) -> UserDetailsViewController {
        let storyboard = UIStoryboard(name: "UserDetails", bundle: nil)
        return storyboard.instantiateViewController(identifier: "UserDetails") { coder in
            UserDetailsViewController(newUserContainer: newUser, coder: coder)
        }
    }
}
