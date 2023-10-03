//
//  Diary .swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//


import UIKit
import FirebaseFirestoreSwift


class DateEntry: Decodable {
    
    var feelingsDate: Date
    var model: Diary
    var uuid: UUID
    
    init(feelingsDate: Date = Date(), model: Diary, uuid: UUID = UUID()) {
        self.feelingsDate = feelingsDate
        self.model = model
        self.uuid = uuid
    }
}

struct Diary: Decodable  {
    // Int becasue we are using the index but it might be possible to keep as a string.
    var sfSymbol: UIImage?
    var flow: String = ""
    var cervicalMucus: String = ""
    var feels: String = ""
    var cravings: String = ""
    var symptoms: String = ""
    var notes: String = ""
    var uuid: UUID = UUID()
    let diaryID: String?
}

//TEACHING NOTE: - BEcuase you are using segemented controll to chose the feels and such.. each `segment` has an Integer associated to it. I wouls save the INT, not the emoji


// MARK: - Extension
extension DateEntry: Equatable {
    static func == (lhs: DateEntry, rhs: DateEntry) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

extension Diary: Equatable {
    static func == (lhs: Diary, rhs: Diary) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
