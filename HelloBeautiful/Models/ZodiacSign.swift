//
//  ZodiacSign.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 11/25/23.
//

import Foundation

enum ZodiacSign: String, CaseIterable {
    case aries
    case taurus
    case gemini
    case cancer
    case leo
    case virgo
    case libra
    case scorpio
    case sagittarius
    case capicorn
    case aquarius
    case pisces
    
    var title: String {
        self.rawValue.capitalized
    }
}
