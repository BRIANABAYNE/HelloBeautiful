//
//  UserDetailsViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/28/23.
//

import Foundation
import UIKit

// MARK: - Protocol
protocol UserDetailsViewModelDelegate: UserDetailsViewController {
    func encountered(_ error: Error)
}

class UserDetailsViewModel {
    
    // MARK: - Properties
    var userDetails: UserDetails?
    let data = ["Aries","Taurus","Gemini","Cancer","Leo","Virgo","Libra","Scorpio","Sagittarius","Capicorn","Aquarius","Pisces"]
    private let service: FirebaseUserDetailServiceable
    weak var delegate: UserDetailsViewModelDelegate?
    
    // MARK: -  Dependency Injection
    init(userDetails: UserDetails? = nil, service: FirebaseUerDetailsService = FirebaseUerDetailsService(), injectedDelegate: UserDetailsViewModelDelegate) {
        self.userDetails = userDetails
        self.service = service
        self.delegate = injectedDelegate
    }
    
    // MARK: - Crud Functions
    func saveUser(zodiacSign: String, cycleLength: String, lastCycle: String, email: String, password: String) {
        if userDetails != nil {
            updateUser(newZodiacSign: zodiacSign, newCycleLength: cycleLength, newLastCycle: lastCycle, email: email, password: password)
        } else {
            createUser(zodiacSign: zodiacSign, cycleLength: cycleLength, lastCycle: lastCycle, email: email, password: password)
        }
    }
    
    func createUser(zodiacSign: String, cycleLength:String, lastCycle: String, email: String, password: String) {
        
       let userAuthID = UserDefaults.standard.string(forKey: "UserAuthID")
        UserDefaults.standard.set(zodiacSign, forKey: "UserZodiacSign")
        let details = UserDetails(zodiacSign: zodiacSign, cycleLength: cycleLength, lastCycle: lastCycle, email: email, password: password, collectionType: Constants.UserDetails.userDetailsCollectionPath, userAuthID: userAuthID)
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

    func updateUser(newZodiacSign: String, newCycleLength: String, newLastCycle: String, email: String, password: String) {
        guard let userToUpdate = self.userDetails else { return }
        let userAuthID = UserDefaults.standard.string(forKey: "UserAuthID")
        let updatedUser = UserDetails(id: userToUpdate.id, zodiacSign: newZodiacSign, cycleLength: newCycleLength, lastCycle: newLastCycle, email: email, password: password, collectionType: Constants.UserDetails.userDetailsCollectionPath, userAuthID: userAuthID)
        service.update(userDetails: updatedUser)
    }
}
