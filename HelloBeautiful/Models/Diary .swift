//
//  Diary .swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//

import Foundation

struct Diary: Decodable {
    var flow: String
    var cervicalMucus: String
    var feels: String
    var cravings: String
    var symptoms: String
    var notes: String
}


//TEACHING NOTE: - BEcuase you are using segemented controll to chose the feels and such.. each `segment` has an Integer associated to it. I wouls save the INT, not the emoji
