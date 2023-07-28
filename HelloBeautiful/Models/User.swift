//
//  User.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//

import Foundation
import FirebaseFirestoreSwift


// This is the user data to the user after they are logged in on firebase and it not important information to be an auth user
struct User: Codable {
    @DocumentID var id: String?
    let firstName: String
    let lastName: String
    let email: String
    let password: String 
    let zodiacSign: String
    let lastCycle: String
    let collectionType: String 
    let uuid: UUID = UUID()

}
extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
