//
//  MoonPhase.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//

import Foundation

struct TopLevelDictionary: Decodable {
//    let timestamp: Int
//    let datestamp: String
    let moon: Moon
}

struct Moon: Decodable {
    private enum CodingKeys: String, CodingKey {
        case moonPhase = "phase_name"
        case stage
        case illumination
//        case zodiacSign = "zodiac_sign"
        case moonrise
        case moonDistance = "moon_distance"
    }
    
    let moonPhase: String
    let stage: String
    let illumination: String
//    let zodiacSign: String
    let moonrise: String
    let moonDistance: Double
}
