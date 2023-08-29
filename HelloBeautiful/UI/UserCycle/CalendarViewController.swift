//
//  CalendarViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/28/23.
//

import UIKit

class CalendarViewController: UIViewController {

    
    
    var calendarView: UICalendarView = {
        let calendarObject = UICalendarView()
        
        calendarObject.calendar = Calendar(identifier: .gregorian)
        return calendarObject
    }()
    
    // MARK: - Properties

    var viewModel: CalendarViewModel!
    let shared = CalendarViewModel.shared
    
    
//let shared = CalendarViewModel.shared
    
  
    
    
// MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCalendar()
        calendarView.delegate = shared
        calendarView.tintColor = .systemPink
        viewModel = CalendarViewModel()
       
    }
    
    // MARK: - Action
    
    @IBAction func editCycleButtonTapped(_ sender: Any) {
        
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


} // end of VC

// MARK: - Extension
extension CalendarViewController: UICalendarSelectionMultiDateDelegate {
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        
        
        CalendarViewModel.shared.createUserCycle(cycleType:   CycleType.startedCycle, dates: selection.selectedDates)
        calendarView.reloadDecorations(forDateComponents: selection.selectedDates, animated: true)
        //        DateDateBase.shared.selectedDates = selection.selectedDates
        print(selection.selectedDates)
        
        
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        viewModel.deleteUserCycle(date: dateComponents)
//        shared.deleteUserCycle(date: dateComponents)
        calendarView.reloadDecorations(forDateComponents: [dateComponents], animated: true)
        
    }
} // end of extension 

