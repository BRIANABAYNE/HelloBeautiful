//
//  User.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    let email: String
    let password: String
    let confirimPassword: String
    let zodiacSign: String
    let collectionType: String
    
}
