//
//  DataExtension.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/1/23.
//

import Foundation

extension Date {
    /// Formats date to look like this:  September 12, 2023
    func formattedForEntry() -> String {
        formatted(date: .long, time: .omitted)
    }
}
