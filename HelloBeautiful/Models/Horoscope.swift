//
//  Horoscope.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//

import Foundation

struct Horoscope: Decodable {
    private enum CodingKeys: String, CodingKey {
        case horoscope
        case sunSign = "sunsign"
        case week
    }

    let horoscope: String
    let sunSign: String
    let week: String
}
