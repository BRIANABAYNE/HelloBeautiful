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
    func update(userDetails: UserDetails)
    func save(userDetails: UserDetails, completion: @escaping(Result<String, FirebaseError>) -> Void)

}

struct FirebaseUerDetailsService: FirebaseUserDetailServiceable {
    
    func save(userDetails: UserDetails, completion: @escaping(Result<String, FirebaseError>) -> Void ) {
        let ref = Firestore.firestore()
        do {
            let documentRef = try ref.collection(Constants.UserDetails.userDetailsCollectionPath).addDocument(from: userDetails, completion: { _ in
                
            })
           
            UserDefaults.standard.set(documentRef.documentID, forKey: "UserDocumentID")
            completion(.success(documentRef.documentID))
        } catch {
            print("Oh no, something went wrong with the save", error.localizedDescription)
            return
        }
    } // end of save
    
    func update(userDetails: UserDetails) {
        if let documentID = userDetails.id {
            let ref = Firestore.firestore()
            let docRef = ref.collection(Constants.UserDetails.userDetailsCollectionPath).document(documentID)
            
            do {
                try docRef.setData(from: userDetails)
            } catch {
                print(error)
            }
        }
    }
} 
