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
    let zodiacSign: Int
    let cycleLength: Int
    let lastCycle: Date
    var email: String
    var password: String
    let collectionType: String
    let userAuthID: String?
    let cycle: [PeriodCycle]

}
