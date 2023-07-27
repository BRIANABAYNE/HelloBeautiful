//
//  CreateUserViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/27/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

struct CreateUserViewModel {
    
    
    // MARK: - Properties
    var user: User?
    
    
    func create(firstName: String, lastName: String, email: String, password: String, lastCycle: String, periodLength: Int, zodiacSign: String, completion: @escaping(Result<String,FirebaseError>) -> Void) {
        let user = User(firstName: firstName, lastName: lastName, email: email, password: password, zodiacSign: zodiacSign, lastCycle: lastCycle , collectionType: Constants.User.userCollectionPath)
    }
    
        
    
    func update(user: User) {
        if let documentID = user.id {
            let ref = Firestore.firestore()
            let docRef = ref.collection(Constants.User.userCollectionPath).document(documentID)
            
            do {
            try docRef.setData(from: user)
        } catch {
            print(error)
        }
    }
    
    
    func save() {
        
    }
    
    
    
    }
    
    

