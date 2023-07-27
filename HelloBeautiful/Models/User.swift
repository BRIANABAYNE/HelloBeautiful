//
//  User.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//

import Foundation

struct User: Decodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String 
    let zodiacSign: String
    let lastCycle: String
    let uuid: UUID

}
extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
