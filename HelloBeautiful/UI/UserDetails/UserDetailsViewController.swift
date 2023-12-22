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
    @IBOutlet weak var zodiacSignPicker: UIButton!
    
    // MARK: - Properties
    
    var viewModel: UserDetailsViewModel!
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
        setupSignPicker()
        periodLengthTextField.set(placeholder: "Typical Cycle Length")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(newUserContainer)
        lastCycleTextField.makeFirstResponder()
    }
    
    // MARK: - Setup
    
    private func setupSignPicker() {
        zodiacSignPicker.changesSelectionAsPrimaryAction = true
        zodiacSignPicker.showsMenuAsPrimaryAction = true
        zodiacSignPicker.menu = zodiacSignMenu
        zodiacSignPicker.preferredMenuElementOrder = .fixed
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

    @IBAction func buttonTapped(_ sender: Any) {
        guard
            let zodiacSign = zodiacSignPicker,
//            let zodiacSignAsInt = Int(zodiacSign),
            let length = periodLengthTextField.text,
            let cycleLength = Int(length)
        else { return }
        
//        viewModel.saveUser(
//            email: email,
//            password: password,
//            zodiacSign: zodiacSign,
//            typicalCycleLength: cycleLength,
//            lastCycleDate: datePicker.date
//        )
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let navigation = storyboard.instantiateViewController(identifier:"tabBar")
        self.view.window?.rootViewController = navigation
    }
    
    // MARK: - View Properties
    
    private lazy var zodiacSignMenu: UIMenu = {
        UIMenu(
            title: "Zodiac Sign",
            options: .singleSelection,
            children: zodiacSignActions
        )
        
    }()
    
    private lazy var zodiacSignActions: [UIAction] = {
        ZodiacSign.allCases.map { sign in
            UIAction(title: sign.title) { _ in
                print("\(sign.title) tapped")
            }
        }
    }()
}

// MARK: - Extensions

extension UserDetailsViewController {
    static func create(with newUser: NewUser) -> UserDetailsViewController {
        let storyboard = UIStoryboard(name: "UserDetails", bundle: nil)
        return storyboard.instantiateViewController(identifier: "UserDetails") { coder in
            UserDetailsViewController(newUserContainer: newUser, coder: coder)
        }
    }
}
