//
//  User.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 11/26/23.
//

import Foundation

struct User {
    
    let email: String
    let cycle: [PeriodCycle]
}

struct PeriodCycle {
    let startDate: Date
    let duration : Int
    let diary: [DiaryEntry]
}

struct DiaryEntry {
    let flow: Int
    let cervicalMucus: Int
    let feels: Int
    let cravings: Int
    let symptoms: Int
}

enum Flow: Int, CaseIterable {
    case light
    case medium
    case heavy
    case superHeavy
    
    var flowTitle: String {
        switch self {
        case .light:
            "Light 💧"
        case .medium:
            "Medium 🩸"
        case .heavy:
            "Heavy 🩸🩸"
        case .superHeavy:
            "Super 🌶️🌶️"
        }
        return ""
    }
}
enum CervicalMucus: Int, CaseIterable {
    case watery
    case thick
    case sticky
    case dry
    
    var mucusTitle: String {
        switch self {
        case .watery:
            "Watery 🔫"
        case .thick:
            "Thick 🥚"
        case .sticky:
            "Sticky 💦"
        case .dry:
            "Dry 🌵"
        }
        return ""
    }
}

enum Feels: Int, CaseIterable {
    case happy
    case horney
    case sad
    case lonely
    
    var feelingsTitle: String {
        switch self {
        case .happy:
            "Happy 😍"
        case .horney:
            "Horney 🫦"
        case .sad:
            "Sad 💔"
        case .lonely:
            "Lonely 🎭"
        }
        return ""
    }
}

enum Cravings: Int, CaseIterable {
    case sweets
    case fats
    case carbs
    case greens
    
    var cravingTitle: String {
        switch self {
        case .sweets:
            "Sweets 🧁"
        case .fats:
            "Fats 🍟"
        case .carbs:
            "Carbs 🍝"
        case .greens:
            "Greens 🥦"
        }
        return ""
    }
}

enum Symptoms: Int, CaseIterable {
    case cramps
    case tender
    case bloated
    case fatigue
    
    var symptomsTitle: String {
        switch self {
        case .cramps:
            "Cramps 🔪"
        case .tender:
            "Tender Breast 🍒"
        case .bloated:
            "Bloated 🐋"
        case .fatigue:
            "Fatigue 💤"
        }
        return ""
    }
}
