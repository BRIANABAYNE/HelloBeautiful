//
//  UserDetails.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/1/23.
//

import Foundation
import FirebaseFirestoreSwift



struct UserDetails: Codable {
    var id: String?
    let zodiacSign: String
    let cycleLength: String
    let lastCycle: String
    let collectionType: String
    
//
//    init(uid: String, dictionary: [String: Any]) {
//        self.uid = uid
//        self.zodiacSign = dictionary["zodiacSign"] as? String ?? ""
//        self.cycleLength = dictionary["cycleLength"] as? String ?? ""
//        self.lastCycle = dictionary["lastCycle"] as? String ?? ""
//        self.collectionType = dictionary["collectionType"] as? String ?? ""
//    }

}




