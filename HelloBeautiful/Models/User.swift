//
//  User.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 11/26/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    let email: String
    let password: String
    let zodiacSign: Int
    let lastCycleDate: Date
    let typicalCycleLength: Int
    let collectionType: String
    let userAuthID: String?
//    let dairy: [DiaryEntry]
//    let cycle: [PeriodCycle]
}

struct PeriodCycle: Codable {
    let startDate: Date
    let duration : Int
    var dateComponent: DateComponents
//    var cycleType: String?
//    var cycleCollectionType: String?
    var diary: [DiaryEntry]
}

struct DiaryEntry: Decodable, Encodable {
    @DocumentID var id: String?
    let flow: Int
    let cervicalMucus: Int
    let feels: Int
    let cravings: Int
    let symptoms: Int
    let notes: String
    let date: Date
    var feelingsCollectionType: String?
}

extension DiaryEntry {
    init(
        flow: Int,
        cervicalMucus: Int,
        feels: Int,
        cravings: Int,
        symptoms: Int,
        notes: String,
        feelingsCollectionType: String?
    ) {
        self.id = nil 
        self.flow = flow
        self.cervicalMucus = cervicalMucus
        self.feels = feels
        self.cravings = cravings
        self.symptoms = symptoms
        self.notes = notes
        self.date = .init()
        self.feelingsCollectionType = feelingsCollectionType
    }
}

enum Flow: Int, CaseIterable {
    case light
    case medium
    case heavy
    case superHeavy
    
    var flowTitle: String {
        switch self {
        case .light:
            return "Light 💧"
        case .medium:
            return "Medium 🩸"
        case .heavy:
            return "Heavy 🩸🩸"
        case .superHeavy:
            return "Super 🌶️🌶️"
        }
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
            return "Watery 🔫"
        case .thick:
            return "Thick 🥚"
        case .sticky:
            return "Sticky 💦"
        case .dry:
            return "Dry 🌵"
        }
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
            return "Happy 😍"
        case .horney:
            return "Horney 🫦"
        case .sad:
            return "Sad 💔"
        case .lonely:
            return "Lonely 🎭"
        }
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
            return "Sweets 🧁"
        case .fats:
            return "Fats 🍟"
        case .carbs:
            return "Carbs 🍝"
        case .greens:
            return "Greens 🥦"
        }
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
            return "Cramps 🔪"
        case .tender:
            return "Tender Breast 🍒"
        case .bloated:
            return "Bloated 🐋"
        case .fatigue:
            return "Fatigue 💤"
        }
    }
}

//extension PeriodCycle: Equatable {
////    static func == (lhs: PeriodCycle, rhs: PeriodCycle) -> Bool {
////        <#code#>
////    }
//
//
//}
