//
//  DateDatabase.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 9/17/23.
//

import UIKit

enum CycleType: String  {
    case startedCycle, none, ovulation
}

#warning("Maybe this is a service OR a ViewModel")
class DateDateBase: NSObject {
    
    public static let shared: DateDateBase = DateDateBase()
    
//    private init() {
//
//    }
    
    // MARK: - Properties
    //    let userCycle: [UserCycle] = []
    var selectedDates: [DateComponents] = []
    var userCycles: [UserCycle] = []
   // var userOvulations: [UserOvulation] = []
    
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
            let userCycle = UserCycle(dateComponent: date, cycleType: cycleType)
            userCycles.append(userCycle)
        }
        
        // I would need this case to trigger once a user puts in their cycle to calculate when they will be ovulating.
        
        func createUserOvulation(to startDate: DateComponents) -> Date {
            let cycleCalendar = Calendar.current
            var startDate = startDate.date!
            let futureDate = cycleCalendar.date(byAdding: .day, value: 14, to: startDate)
            print(futureDate!)
            return futureDate!
        }
        
        func removeCycle(date: DateComponents) {
            
        }
//        let mockDate = DateComponents(calendar: .autoupdatingCurrent, year: 2023, month: 8, day:28)
//        createUserOvulation(to: mockDate)
        

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
        var foo = userCycles.first(where: {$0.dateComponent.date! == date.date})
        let index = userCycles.firstIndex(of: foo!)
        userCycles.remove(at: index!)
    }
    
    func saveUserCycle(cycleType: CycleType, dates:[DateComponents] ) {
        
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

extension DateDateBase: UICalendarViewDelegate {
   
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        eventOneCalendar(date: dateComponents)
    }
}
