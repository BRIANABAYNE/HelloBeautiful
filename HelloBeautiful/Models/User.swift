//
//  User.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    var id: String?
    var email: String
    var password: String
//    let zodiacSign: String
    var collectionType: String
    
//    
//    init(UID: String, dictionary: [String: Any]) {
//        self.UID = UID
//        self.email = dictionary["email"] as? String ?? ""
//        self.password = dictionary["password"] as? String ?? ""
//        self.collectionType = dictionary["collectionType"] as? String ?? ""
//    }
//    
//    
//    
//    var dictionaryRepresentation: [String: Any] {
//        var dictionary = [:]
//        dictionary["id"] = id
//        dictionary["email"] = email
//        dictionary["password"] = password
//        dictionary["collectionType"] = collectionType
//    }
    
    
    
}


