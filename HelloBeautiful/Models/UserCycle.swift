//
//  Cycle.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 9/17/23.
//

import Foundation
import FirebaseFirestoreSwift

struct UserCycle: Encodable {
    
 var dateComponent: DateComponents
   var cycleType: String
   var cycleCollectionType: String?
}
extension UserCycle: Equatable {
    
}
// User -> cycles:periodCycle
//diary[DiaryEntry] // text: String, Cravings: Int, 
