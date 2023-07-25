//
//  MoonPhase.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let datestamp: String
    let moon: [Moon]
    
}

struct Moon: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case illumination
        case moonPhase = "phase_name"
        case zodiacSign = "zodiac_sign"
        case moonrise
        case moonDistance = "moon_distance"
        
    }
    
    let illumination: String
    let moonPhase: String
    let zodaicSign: String
    let moonrise: String
    let moonDistance: Double
    
}
