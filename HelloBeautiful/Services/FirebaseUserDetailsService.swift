//
//  CrudFunctions.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/27/23.
//

import FirebaseFirestore
import Foundation
import FirebaseStorage
import FirebaseFirestoreSwift

protocol FirebaseUserDetailServiceable {
    func userDetails(zodiacSign: String, cycleLength:String, lastCycle: String, completion: @escaping(Result<String, Error>) -> Void)
    func save(userDetails: UserDetails, completion: @escaping(Result<String, FirebaseError>) -> Void)
    func updateUser(newZodiacSign: String, newCycleLength: String, newLastCycle: String)
}

struct FirebaseUerDetailsService: FirebaseUserDetailServiceable {
    
    func userDetails(zodiacSign: String, cycleLength:String, lastCycle: String, completion: @escaping(Result<String, Error>) -> Void) {
        let userDetails = UserDetails(zodiacSign: zodiacSign, cycleLength: cycleLength, lastCycle: lastCycle, collectionType: Constants.UserDetails.userDetailsCollectionPath)
        
        save(userDetails: userDetails) { result in
            switch result {
            case .success(let docID):
                completion(.success(docID))
            case .failure(let failure):
                print(failure)
            }
        }
    } // end of user details
    
    func save(userDetails: UserDetails, completion: @escaping(Result<String, FirebaseError>) -> Void ) {
        let ref = Firestore.firestore()
        do {
            let documentRef = try ref.collection(Constants.UserDetails.userDetailsCollectionPath).addDocument(from: userDetails, completion: { _ in
                
            })
            completion(.success(documentRef.documentID))
        } catch {
            print("Oh no, something went wrong with the save", error.localizedDescription)
            return
        }
    } // end of save
    
    func updateUser(newZodiacSign: String, newCycleLength: String, newLastCycle: String) {
    
        let updateUser = UserDetails(zodiacSign: newZodiacSign, cycleLength: newCycleLength, lastCycle: newLastCycle, collectionType:Constants.UserDetails.userDetailsCollectionPath)
       
        update(userDetails: updateUser)
        
    } // end of updateUser
    
    func update(userDetails: UserDetails) {
        if let documentID = userDetails.id {
            let ref = Firestore.firestore() // path to fireStore
            let docRef = ref.collection(Constants.UserDetails.userDetailsCollectionPath).document(documentID) // collection, doc, collection, doc
            
            do {
                try docRef.setData(from: userDetails)
            } catch {
                print(error)
            }
        }
        
    } // end of update
} // end of struct 
