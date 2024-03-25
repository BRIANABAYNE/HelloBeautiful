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
    
    var userDetails: User?
    let zodiacSigns = ZodiacSign.allCases.map(\.title)
    private let service: FirebaseAuthService
  //  let serviceOne: FirebaseAuthServiceable
    weak var delegate: UserDetailsViewModelDelegate?
    
    // MARK: -  Dependency Injection
    
    init(
        userDetails: User? = nil,
        service: FirebaseAuthService = FirebaseAuthService(),
        injectedDelegate: UserDetailsViewModelDelegate
       // serviceOne: FirebaseAuthService = FirebaseAuthService()
    ) {
        self.userDetails = userDetails
        self.service = service
        self.delegate = injectedDelegate
      //  self.serviceOne = serviceOne
    }
    
    // MARK: - Crud Functions
    
    func saveUser(
        email: String,
        password: String,
        zodiacSign: String,
        typicalCycleLength: Int,
        lastCycleDate: Date
    ) {
        if userDetails != nil {
            updateUser(
                email: email,
               password: password,
                newZodiacSign: zodiacSign,
                newTypicalCycleLength: typicalCycleLength,
                newLastCycleDate: lastCycleDate)
        } else {
            createUser(
                email: email,
                password: password,
                zodiacSign: zodiacSign,
                typicalCycleLength:typicalCycleLength,
                lastCycleDate: lastCycleDate)
        }
    }
    
    func createUser(
        email: String,
        password: String,
        zodiacSign: String,
        typicalCycleLength: Int,
        lastCycleDate: Date
    ) {
        
        let userAuthID = UserDefaults.standard.string(forKey: "UserAuthID")
        UserDefaults.standard.set(zodiacSign, forKey: "UserZodiacSign")
        let details = User(
            email: email,
            password: password,
            zodiacSign: zodiacSign,
            lastCycleDate: lastCycleDate,
            typicalCycleLength: typicalCycleLength,
            collectionType: Constants.User.userDetailsCollectionPath,
            userAuthID: userAuthID)
        service.save(userDetails: details, completion: { result in
            switch result {
            case .success(_):
                print("User was created")
                self.service.createAccount(with: email, password: password) { result in
                    //
                }
            case .failure(let failure):
                print("There was an error creating the user.")
                self.delegate?.encountered(failure)
            }
        })
    }

    func updateUser(
        email: String,
        password: String,
        newZodiacSign: String,
        newTypicalCycleLength: Int,
        newLastCycleDate: Date
    ) {
        guard let userToUpdate = self.userDetails else { return }
        let userAuthID = UserDefaults.standard.string(forKey: "UserAuthID")
        let updatedUser = User(
            id: userToUpdate.id,
            email: email,
            password: password,
            zodiacSign: newZodiacSign,
            lastCycleDate: newLastCycleDate,
            typicalCycleLength: newTypicalCycleLength,
            collectionType: Constants.User.userDetailsCollectionPath,
            userAuthID: userAuthID)
        service.update(userDetails: updatedUser)
    }
    
    func createAccount(
        with email: String,
        password: String
    ) {
        service.createAccount(with: email, password: password) { result in
            switch result {
            case .success(_):
                print("User was created successfully")
#warning("Should we only change the UI if signing in was successful??")
            case .failure(let failure):
                print("User was not created")
                self.delegate?.encountered(failure)
            }
        }
    }
}
