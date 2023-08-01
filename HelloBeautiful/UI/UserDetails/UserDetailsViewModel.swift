//
//  UserDetailsViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/28/23.
//

import Foundation
import UIKit

struct UserDetailsViewModel {
    
    
    // MARK: - Properties
    
    var window: UIWindow!
    var userDetails: UserDetails?

    let data = ["Aries","Taurus","Gemini","Cancer","Leo","Virgo","Libra","Scorpio","Sagittarius","Capicorn","Aquarius","Pisces"]

    func userDetails(lastCycle: UIDatePicker, zodiacSign: String, cycleLength: Int, completion: @escaping(Result<UserDetails, Error>) -> Void) {
        let userDetails = UserDetails(zodiacSign: zodiacSign, cycleLength: cycleLength, lastCycle: lastCycle)
        
        
    }
    
    
    
    
    
}
