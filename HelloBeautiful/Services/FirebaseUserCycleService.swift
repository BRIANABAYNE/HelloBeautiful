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

protocol FirebaseUserCycleServiceable {
    
    func saveUserCycle(userCycle: UserCycle, completion: @escaping(Result<String, FirebaseError>) -> Void)
    func fetchUserCycle(completion: @escaping(Result<[UserCycle], FirebaseError>) -> Void)
}

struct FirebaseUserCycleService: FirebaseUserCycleServiceable {
    
    func saveUserCycle(
        userCycle: UserCycle,
        completion: @escaping(Result<String, FirebaseError>) -> Void) {
        let firebaseRef = Firestore.firestore()
        do {
            let userDocID = UserDefaults.standard.string(forKey: "UserDocumentID")
            let documentCycleRef = try
            firebaseRef
                .collection(Constants.User
                    .userDetailsCollectionPath)
                .document(userDocID!)
                .collection(Constants.UserCycle.userCycleCollectionPath)
                .addDocument(from: userCycle, completion: { _ in
                })
            completion(.success(documentCycleRef.documentID))
        } catch {
            print("Oh no, something went wrong with saving the cycle", error.localizedDescription)
            
            return
        }
    }
        
    func fetchUserCycle(completion: @escaping(Result<[UserCycle], FirebaseError>) -> Void) {
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
