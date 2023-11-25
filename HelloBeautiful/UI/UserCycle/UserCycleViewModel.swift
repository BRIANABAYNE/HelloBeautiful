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
    private let userCycleService: FirebaseUserCycleServicable
    weak var cycleDelegate: UserCycleViewModelDelegate?
    
//     MARK: - Dependency Injection
    init(userCycleService: FirebaseUserCycleService = FirebaseUserCycleService(), injectedDelegate: UserCycleViewModelDelegate) {
        self.userCycleService = userCycleService
        self.cycleDelegate = injectedDelegate
    }
    // MARK: - Functions
    func createUserCycle(cycleType: CycleType, dates: [DateComponents])  {
        
        for date in dates {
            // Compare the date to all the dates in the user cycle
            //            var foo = userCycles.first(where: {$0.dateComponent.date! == date.date})
            //            print(foo)
            //            if foo == nil {
            //                let userCycle = UserCycle(dateComponent: date, cycleType: .startedCycle)
            //                userCycles.append(userCycle)
            //            } else {
            //                let index = userCycles.firstIndex(of: foo!)
            //                userCycles.remove(at: index!)
            //            }
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
                })
            }
        
        

        // How to determin when a user will ovulate
        // The average menstrual cycle is 28 days long
        // the range can be anywhere from 21 to 35 days in a cycle
        // A cycle is counted from the first day of the first date of the period to the next period
        // SO if user starts on 8/8 the next cycle will start on 9/4 if we are going off the average cycle of 28 days
        //Leuteal Phase = 12 to 14
        // Minus 14 days from your cycle and get the day you should start ovulating on
        // 19 to 24th will ovulate
    }
    
    func deleteUserCycle(date: DateComponents) {
        let userCycleInfo = userCycles.first(where: {$0.dateComponent.date! == date.date})
        let index = userCycles.firstIndex(of: userCycleInfo!)
        userCycles.remove(at: index!)
    }
    
    
    func editUserCycle() {
        
    }

//    private func cycleStatus(date: DateComponents) -> CycleType {
//        if let components = userCycles.filter({$0.dateComponent.date == date.date}).first {
//            return components.cycleType
//        }
//        return.none
//    }
    
    func addEvent() -> UICalendarView.Decoration? {
        return .image(UIImage(systemName: "drop.fill"),color: .red)
    }
    
    func removeEvent() -> UICalendarView.Decoration? {
        return .image(nil)
    }
    // date == the date the cal is tryign to create the decoration on.
    func eventOneCalendar(date: DateComponents) -> UICalendarView.Decoration? {
        // if the date is not in the usercycles.. set it to heart
//        var foo = userCycles.first(where: {$0.dateComponent.date! == date.date})
//                    print(foo)
//                    if foo == nil {
//                        let userCycle = UserCycle(dateComponent: date, cycleType: .startedCycle)
//                        userCycles.append(userCycle)
//                    } else {
//                        let index = userCycles.firstIndex(of: foo!)
//                        userCycles.remove(at: index!)
        if let components = userCycles.filter({$0.dateComponent.date == date.date}).first {
            return .image(UIImage(systemName: "drop.fill"),color: .red)
        }
//                    }
//        let cycleDates = cycleStatus(date: date)
//
//        switch cycleDates {
//        case .startedCycle:
//            return .image(UIImage(systemName: "drop.fill"),color: .red)
//        case .none:
//            return nil
//      case .ovulation:
//            return .image(UIImage(systemName:""))
//
//        }
        // compare this date with the dates in the usercyles so we can pull out the cycle type
        
        //            let cycleDates = cycleStatus(date: date)
        
        return nil
    }
    
} // end of class

// MARK: - Extension
extension UserCycleViewModel: UICalendarViewDelegate {
   
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        eventOneCalendar(date: dateComponents)
    }
}
