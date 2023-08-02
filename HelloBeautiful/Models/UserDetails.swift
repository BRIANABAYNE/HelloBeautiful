//
//  UserDetails.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/1/23.
//

import Foundation
import FirebaseFirestoreSwift


struct UserDetails: Codable {
    @DocumentID var id: String?
    let zodiacSign: String
    let cycleLength: String
    let lastCycle: String
    let collectionType: String
//    var uuid: UUID = UUID()
    
}


//
//extension UserDetails: Equatable {
//    static func == (lhs: UserDetails, rhs: UserDetails) -> Bool {
//        return lhs.uuid == rhs.uuid
//    }

