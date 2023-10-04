//
//  UserDetailsViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/28/23.
//

import Foundation
import UIKit

// creating a job req
protocol UserDetailsViewModelDelegate: UserDetailsViewController {
    func encountered(_ error: Error)
}

class UserDetailsViewModel {
    
    
    // MARK: - Properties
    var userDetails: UserDetails?
    
  
    let data = ["Aries","Taurus","Gemini","Cancer","Leo","Virgo","Libra","Scorpio","Sagittarius","Capicorn","Aquarius","Pisces"]
    
    // created the position. This is their empolyee number when they are hired.
    private let service: FirebaseUserDetailServiceable
    weak var delegate: UserDetailsViewModelDelegate?
    
    
    // MARK: -  Dependency Injection
    init(userDetails: UserDetails? = nil, service: FirebaseUerDetailsService = FirebaseUerDetailsService(), injectedDelegate: UserDetailsViewModelDelegate) {
        self.userDetails = userDetails
        self.service = service
        self.delegate = injectedDelegate
    }
    
    
    func saveUser(zodiacSign: String, cycleLength: String, lastCycle: String) {
        if userDetails != nil {
            updateUser(newZodiacSign: zodiacSign, newCycleLength: cycleLength, newLastCycle: lastCycle)
        } else {
            createUser(zodiacSign: zodiacSign, cycleLength: cycleLength, lastCycle: lastCycle)
        }
    }
    
    func createUser(zodiacSign: String, cycleLength:String, lastCycle: String) {
        
//         UserDefaults.standard.set(zodiacSign, forKey: "UserZodiacSign")
        
        let details = UserDetails(zodiacSign: zodiacSign, cycleLength: cycleLength, lastCycle: lastCycle, collectionType: Constants.UserDetails.userDetailsCollectionPath)
        service.save(userDetails: details, completion: { result in
            switch result {
            case .success(_):
                print("User Deatils Were Created")
            case .failure(let failure):
                print("There was an error creating the user.")
             self.delegate?.encountered(failure)
            }
        })
    }
  
    
    
    func updateUser(newZodiacSign: String, newCycleLength: String, newLastCycle: String) {
        guard let userToUpdate = self.userDetails else { return }
        let updatedUser = UserDetails(id: userToUpdate.id, zodiacSign: newZodiacSign, cycleLength: newCycleLength, lastCycle: newLastCycle, collectionType: Constants.UserDetails.userDetailsCollectionPath)
        
        service.update(userDetails: updatedUser)
        
    }
    
    
    
    
    
} // end of ViewModel


