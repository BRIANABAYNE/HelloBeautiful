//
//  Diary .swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//


import UIKit
import FirebaseFirestoreSwift

struct Diary: Decodable, Encodable  {
 
   @DocumentID var id: String?
    var flow: Int
    var cervicalMucus: Int
    var feels: Int
    var cravings: Int
    var symptoms: Int
    var notes: String
    var date: Date = Date()
    var feelingsCollectionType: String?
}
