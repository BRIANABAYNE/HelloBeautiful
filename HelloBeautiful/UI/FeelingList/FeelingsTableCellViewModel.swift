//
//  FeelingsTableCellViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 11/27/23.
//

import Foundation

class FeelingsTableCellViewModel {
    
    private let entry: DiaryEntry
    
    init(entry: DiaryEntry) {
        self.entry = entry
    }
    
    var title: String {
        entry.date.formattedForEntry()
    }
    
    var subtitle: String {
        entry.notes
    }
    
    var entryViewModel: FeelingsViewModel {
        .init(entry: entry)
    }
}
