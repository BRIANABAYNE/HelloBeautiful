//
//  DateDatabaseService.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/28/23.
//

import UIKit

enum CycleType: String {
    case startedCycle, none, ovulation
}

class CalendarViewModel: NSObject {
    
    
    
public static let shared: CalendarViewModel = CalendarViewModel()
    
    
    // MARK: - Properties
    var selectedDates: [DateComponents] = []
    var userCycles: [UserCycle] = []
    
    
    
    
    // MARK: - Functions
    func createUserCycle(cycleType: CycleType, dates: [DateComponents]) {
        
        
        for date in dates {
            let userCycle = UserCycle(dateComponent: date, cycleType: cycleType)
            userCycles.append(userCycle)
        } // end of 4In
        
        
    }
    
    
    func createUserOvulation(to startDate: DateComponents) -> Date {
        let cycleCalendar = Calendar.current
        var startDate = startDate.date!
        let futureDate = cycleCalendar.date(byAdding: .day, value: 14, to: startDate)
        print(futureDate!)
        return futureDate!
    }
    
    func removeCycle(date: DateComponents) {
        
    }
    
    func deleteUserCycle(date: DateComponents) {
        var cycle = userCycles.first(where: {$0.dateComponent.date! == date.date})
         let index = userCycles.firstIndex(of: cycle!)
              userCycles.remove(at: index!)
    }
    
    func saveUserCycle(cycleType: CycleType, dates: [DateComponents]) {
        

    }
    
    func editUserCycle() {
        
    }
    
    func addEvent() -> UICalendarView.Decoration? {
        return.image(UIImage(systemName: "drop.fill"), color: .red)
    }
    
    func removeEvent() -> UICalendarView.Decoration? {
        return.image(nil)
    }
    
    func eventOneCalendar(date: DateComponents) -> UICalendarView.Decoration? {
        if let components = userCycles.filter({$0.dateComponent.date == date.date}).first {
            return.image(UIImage(systemName: "drop.fill"), color: .red)
            
            
        }
        return nil
    } // end of eventOneCalendar
    
    
} // end of Date

// MARK: - Extension
extension CalendarViewModel: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        eventOneCalendar(date: dateComponents)
    }
}
