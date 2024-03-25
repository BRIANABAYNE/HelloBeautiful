//
//  DateDatabase.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 9/17/23.
//

import UIKit

// MARK: - Protocol

protocol UserCycleViewModelDelegate: UserCycleViewController {
    func successfullyLoadedCycleData()
    func encountered(_ error: Error)
}

// MARK: - Enum

enum CycleType: String  {
    case startedCycle, none, ovulation
}

class UserCycleViewModel: NSObject {
    
    // MARK: - Properties
    var selectedDates: [DateComponents] = []
    var userCycles: [UserCycle] = []
    private let userCycleService: FirebaseUserCycleServiceable
    weak var cycleDelegate: UserCycleViewModelDelegate?
    
//     MARK: - Dependency Injection
    
    init(
        userCycleService: FirebaseUserCycleService = FirebaseUserCycleService(),
        injectedDelegate: UserCycleViewModelDelegate
    ) {
        self.userCycleService = userCycleService
        self.cycleDelegate = injectedDelegate
    }
    
    // MARK: - Functions
    
    func createUserCycle(
        cycleType: CycleType,
        dates: [DateComponents])
    {
        for date in dates {
            
            let userCycle = UserCycle(dateComponent: date, cycleType: cycleType.rawValue)
            userCycles.append(userCycle)
        }
    }
        
        // I would need this case to trigger once a user puts in their cycle to calculate when they will be ovulating.
        
        func createUserOvulation(to startDate: DateComponents) -> Date {
            let cycleCalendar = Calendar.current
            let startDate = startDate.date!
            let futureDate = cycleCalendar.date(byAdding: .day, value: 14, to: startDate)
            print("This is the future date!!!!",futureDate!)
            return futureDate!
        }
        
        func removeCycle(date: DateComponents) {
            
        }
        
        func saveUserCycle() {
            
            for cycle in userCycles {
                
                userCycleService.saveUserCycle(userCycle: cycle, completion: { result in
                    switch result {
                    case .success(_):
                        //                            self.cycleDelegate?.successfullyLoadedCycleData()
                        print("User Cycle was saved to FB")
                    case .failure(let failure):
                        print("There was an error saving the cycle to FB")
                         self.cycleDelegate?.encountered(failure)
                    }
                } )
            }
            
    }
    
    
    
    
    func fetchUserCycle() {
        // This is fetching information but it's not the correct user. // Looks like maybe it's pulling all the users.
        userCycleService.fetchUserCycle { result in
            switch result {
            case .success(_):
                print("Fetched User Cycle from Firebase")
            case .failure(let failure):
                print("There was an error retrieving the cycle information from FB")
                self.cycleDelegate?.encountered(failure)
            }
        }
    }
    
    func deleteUserCycle(date: DateComponents) {
        let userCycleInfo = userCycles.first(where: {$0.dateComponent.date! == date.date})
        let index = userCycles.firstIndex(of: userCycleInfo!)
        userCycles.remove(at: index!)
    }
    
    func editUserCycle() {
        
    }

    func addEvent() -> UICalendarView.Decoration? {
        return .image(UIImage(systemName: "drop.fill"),color: .red)
    }
    
    func removeEvent() -> UICalendarView.Decoration? {
        return .image(nil)
    }

    func eventOneCalendar(date: DateComponents) -> UICalendarView.Decoration? {
        if let components = userCycles.filter({$0.dateComponent.date == date.date}).first
            
        {
            return .image(UIImage(systemName: "drop.fill"),color: .red)
        }
        
        return nil
    }
}

// MARK: - Extension

extension UserCycleViewModel: UICalendarViewDelegate {
    func calendarView(
        _ calendarView: UICalendarView,
        decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration?
    {
        eventOneCalendar(date: dateComponents)
    }
}
