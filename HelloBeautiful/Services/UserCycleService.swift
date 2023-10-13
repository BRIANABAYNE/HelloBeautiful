//
//  UserCycleService.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 10/12/23.
//

import Foundation
import FirebaseFirestore



struct UserCycleService {
    
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
