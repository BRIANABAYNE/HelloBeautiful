//
//  CalendarDelegate.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/28/23.
//

import UIKit


var viewModel: CalendarViewModel!

class CalendarDelegate: NSObject, UICalendarViewDelegate {
    
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        return viewModel.eventOneCalendar(date: dateComponents)
    }
    
}
