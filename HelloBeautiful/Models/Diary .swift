//
//  Diary .swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//


import UIKit
import FirebaseFirestoreSwift


struct FeelingsEntry: Encodable {
    
//    var feelingsDate: Date
    var model: Diary 
//    var uuid: UUID
    
//    init(model: Diary = Diary()) {
//        self.model = model
//    }
}

struct Diary: Encodable  {
    // Int becasue we are using the index but it might be possible to keep as a string.
   // var sfSymbol: UIImage?
    var diaryID: String?
    var flow: String = ""
    var cervicalMucus: String = ""
    var feels: String = ""
    var cravings: String = ""
    var symptoms: String = ""
    var notes: String = ""
    var uuid: UUID = UUID()
    var date: Date = Date()
    var feelingsCollectionType: String?
}

//TEACHING NOTE: - BEcuase you are using segemented controll to chose the feels and such.. each `segment` has an Integer associated to it. I wouls save the INT, not the emoji


// MARK: - Extension

extension Diary: Equatable {
    static func == (lhs: Diary, rhs: Diary) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

extension Date {

      func asString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .long
        return formatter.string(from: self)
    }
}
