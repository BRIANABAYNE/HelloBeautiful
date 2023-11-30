//
//  ViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 9/17/23.
//

import UIKit

class UserCycleViewController: UIViewController, AlertPresentable {
    
    var calendarView: UICalendarView = {
        let calendarObject = UICalendarView()
        calendarObject.calendar = Calendar(identifier: .gregorian)
        return calendarObject
    }()
    
    // MARK: - Properties
    
    var selectedDates: [DateComponents] = []
    var userCycles: [UserCycle] = []
    var viewModel: UserCycleViewModel!

    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCalendar()
        calendarView.delegate = self
        calendarView.tintColor = .systemPink
        viewModel = UserCycleViewModel(injectedDelegate: self)
    }

    // MARK: - Actions
    
    @IBAction func allTheFeelsButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name:"Feelings", bundle: nil)
        let feelings = storyboard.instantiateViewController(identifier:"Symptoms")
        self.view.window?.rootViewController = feelings
#warning("THIS IS BUGGIE")
    }
    
    @IBAction func editCycleButtonTapped(_ sender: Any) {
        viewModel.saveUserCycle()
    }
    
    func setupUI() {
        
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            calendarView.heightAnchor.constraint(equalToConstant: 700)
        ])
    }
    
    func setupCalendar() {
        let multiDaySelection = UICalendarSelectionMultiDate(delegate: self)
        calendarView.selectionBehavior = multiDaySelection
    }
}

// MARK: - Extensions

extension UserCycleViewController: UICalendarViewDelegate {
    func calendarView(
        _ calendarView: UICalendarView,
        decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration?
    {
        return viewModel.eventOneCalendar(date: dateComponents)
    }
}

extension UserCycleViewController: UserCycleViewModelDelegate {
    func encountered(_ error: Error) {
        presentAlert(message: error.localizedDescription, title: "Oh no!")
    }
    
    func successfullyLoadedCycleData() {
        #warning("Look at this")
    }
}

  extension UserCycleViewController: UICalendarSelectionMultiDateDelegate {
      
    func multiDateSelection(
        _ selection: UICalendarSelectionMultiDate,
        didSelectDate dateComponents: DateComponents
    ){
        viewModel.createUserCycle(
            cycleType:   CycleType.startedCycle,
            dates: selection.selectedDates)
        calendarView.reloadDecorations(
            forDateComponents: selection.selectedDates,
            animated: true)
        print("Is this correct", selection.selectedDates)
    }
      
    func multiDateSelection(
        _ selection: UICalendarSelectionMultiDate,
        didDeselectDate dateComponents: DateComponents
    ){
        viewModel.deleteUserCycle(date: dateComponents)
        calendarView.reloadDecorations(
            forDateComponents: [dateComponents],
            animated: true)
    }
}
