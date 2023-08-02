//
//  UserDetails.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/1/23.
//

import Foundation
import FirebaseFirestoreSwift


#warning("Combine this with USER")
struct UserDetails: Codable {
    @DocumentID var id: String?
    let zodiacSign: String
    let cycleLength: String
    let lastCycle: String
    let collectionType: String

}




