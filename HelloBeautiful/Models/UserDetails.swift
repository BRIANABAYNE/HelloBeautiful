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
    
    let zodiacSignAsString: String
}
