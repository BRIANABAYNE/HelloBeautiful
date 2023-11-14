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
    
//    var calendarDelegate: CalendarDelegate!

    // MARK: - Properties
    
    var selectedDates: [DateComponents] = []
    var userCycles: [UserCycle] = []
    
    var viewModel: UserCycleViewModel!
    
    var userCycle: UserCycle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCalendar()
//        calendarDelegate = CalendarDelegate()
//        calendarView.delegate = calendarDelegate
        calendarView.delegate = self
        calendarView.tintColor = .systemPink
        
       viewModel = UserCycleViewModel(injectedDelegate: self)
    }

//    let cycleType = CycleType(rawValue: <#String#>)


    // MARK: - Actions

    @IBAction func allTheFeelsButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name:"Feelings", bundle: nil)
        let feelings = storyboard.instantiateViewController(identifier:"Symptoms")
        self.view.window?.rootViewController = feelings
#warning("THIS IS BUGGIE")
    }
    
    @IBAction func editCycleButtonTapped(_ sender: Any) {
//        let cycleDate = selectedDates
//        let userCycle = calendarView.availableDateRange.start
        viewModel.saveUserCycle()
    }
    
    func setupUI() {
        
        view.addSubview(calendarView)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20) .isActive = true
        calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 700).isActive = true
        
    }
    
    func setupCalendar() {
        let multiDaySelection = UICalendarSelectionMultiDate(delegate: self)
//        calendarView.selectionBehavior = multiDaySelection
//         multiDaySelection.selectedDates = DateDateBase.shared.selectedDates
//        multiDaySelection.selectedDates =
        calendarView.selectionBehavior = multiDaySelection
    }

    
} // end of vc

extension UserCycleViewController: UICalendarViewDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
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
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        
        // If the user has a case that is not .noe.. make it .none.
        // We need to find out if this date has a case and if it is .none or somethign else.
        
        viewModel.createUserCycle(cycleType:   CycleType.startedCycle, dates: selection.selectedDates)
        calendarView.reloadDecorations(forDateComponents: selection.selectedDates, animated: true)
        //        DateDateBase.shared.selectedDates = selection.selectedDates
        print("Is this correct", selection.selectedDates)
    }
      
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        viewModel.deleteUserCycle(date: dateComponents)
        calendarView.reloadDecorations(forDateComponents: [dateComponents], animated: true)
    }
//    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
//        // sThis  shoudl change the case back to none...
////        DateDateBase.shared.createUserCycle(cycleType: CycleType.none, dates: selection.selectedDates)
//        DateDateBase.shared.deleteUserCycle(date: dateComponents)
//        let changedDates
//        calendarView.reloadDecorations(forDateComponents: , animated: true)
//    }
    
// When a user deselect a date, then the date should deselect and the case for that date should also change to none. I believe I can achieve this by adding this information in the delegeate function mulidateSelection - didDeselectDate - The problem with this function is that it's triggering right when the app launches and not when a user deselcts the date. When I put the breakpoints I think the case is trigging even before the calendar data loads. I needs the flow of the data to be calendar load, case 1 to load once I select and next case to trigger when someone deslects. I believe I need to add something into the function that I already have that is  private func cycleStatus(date: DateComponents) -> CycleType. I think I also need to call something in the func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration ?
}
