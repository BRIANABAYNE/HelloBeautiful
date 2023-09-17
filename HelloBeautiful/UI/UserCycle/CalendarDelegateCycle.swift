//
//  CalendarDelegateCycle.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 9/17/23.
//

import UIKit

class CalendarDelegateCycle: NSObject, UICalendarViewDelegate {
   
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return DateDateBase.shared.eventOneCalendar(date: dateComponents)
    }
}
