//
//  UserDetails.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/1/23.
//

import Foundation


struct UserDetails: Codable {
    let zodiacSign: String
    let cycleLength: Int
    let lastCycle: Date
    var uuid: UUID = UUID()
    
}


extension UserDetails: Equatable {
    static func == (lhs: UserDetails, rhs: UserDetails) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
