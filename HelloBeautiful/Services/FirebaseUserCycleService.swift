//
//  UserCycleService.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 10/12/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift
import FirebaseAuth

protocol FirebaseUserCycleServicable {
    func saveUserCycle(userCycle: UserCycle, completion: @escaping(Result<String, FirebaseError>) -> Void)
    
    func fetchUserCycle(completion: @escaping(Result<[UserDetails], FirebaseError>) -> Void)
}

struct FirebaseUserCycleService: FirebaseUserCycleServicable {
    
    
    
    func saveUserCycle(userCycle: UserCycle, completion: @escaping(Result<String, FirebaseError>) -> Void) {
        let firebaseRef = Firestore.firestore()
        do {
            let userDocID = UserDefaults.standard.string(forKey: "UserDocumentID")
            let documentCycleRef = try
            firebaseRef.collection(Constants.UserDetails.userDetailsCollectionPath).document(userDocID!).collection(Constants.UserCycle.userCycleCollectionPath).addDocument(from: userCycle, completion: { _ in
            })
            completion(.success(documentCycleRef.documentID))
        } catch {
            print("Oh no, something went wrong with saving the cycle", error.localizedDescription)
            return
        }
    } // end of save 
        
    
    func fetchUserCycle(completion: @escaping(Result<[UserDetails], FirebaseError>) -> Void) {
        let db = Firestore.firestore()
        db.collection("UserDetails").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
