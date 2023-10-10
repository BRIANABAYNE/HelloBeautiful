//
//  Diary .swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//


import UIKit
import FirebaseFirestoreSwift

struct FeelingsEntry: Encodable {

  var model: Diary
}

struct Diary: Encodable  {
 
    @DocumentID var id: String?
    var flow: String = ""
    var cervicalMucus: String = ""
    var feels: String = ""
    var cravings: String = ""
    var symptoms: String = ""
    var notes: String = ""
    var date: Date = Date()
    var feelingsCollectionType: String?
}
