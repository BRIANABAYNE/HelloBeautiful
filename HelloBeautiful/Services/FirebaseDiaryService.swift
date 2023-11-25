//
//  FirebaseDiaryService.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 10/3/23.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift
import FirebaseAuth

protocol FirebaseDiaryServicable {
    func createDiary(userDiary: Diary, completion: @escaping(Result<String, FirebaseError>) -> Void)
    func fetchDiaryEntries(userID: String, completion: @escaping (Result<[Diary], FirebaseError>) -> Void)
    func updateDiary(userDiary: Diary, handler: @escaping (Result<Bool, FirebaseError>) -> Void)
    func deleteDiary(userDeleteDiary: Diary, completion: @escaping(Result<Bool, FirebaseError>) -> Void)
}
struct FirebaseDiaryService: FirebaseDiaryServicable {
    
    func createDiary(userDiary: Diary, completion: @escaping (Result<String, FirebaseError>) -> Void) {
        let firebaseRef = Firestore.firestore()
        do {
            let userDocID = UserDefaults.standard.string(forKey: "UserDocumentID")
            let documentFeelingsRef = try
            firebaseRef.collection(Constants.UserDetails.userDetailsCollectionPath).document(userDocID!).collection(Constants.Diary.diaryCollectionPath).addDocument(from: userDiary, completion: { _ in
            })
            completion(.success(documentFeelingsRef.documentID))
        } catch {
            print("Oh no, something went wrong with saving the Diary", error.localizedDescription)
            return
        }
    } // end of create
    func fetchDiaryEntries(userID: String, completion: @escaping (Result<[Diary], FirebaseError>) -> Void) {
        let firebaseRef = Firestore.firestore()
        firebaseRef.collection("UserDetails").document(userID).collection("Diary").getDocuments() { snapshot,
            error in
            if let error = error {
                print("Error getting User Docs \(error)")
            } else {
                do {
                    let arrayDiary = try (snapshot?.documents.compactMap({ document in
                        try document.data(as: Diary.self )
                    }))!
                    completion(.success(arrayDiary))
                } catch {
                    completion(.failure(.firebaseError(error)))
                }
            }
            
        }
        
    }
    
    func updateDiary(userDiary: Diary, handler: @escaping (Result<Bool, FirebaseError>) -> Void) {
        let firebaseRef = Firestore.firestore()
        if let documentID = userDiary.id {
            let userDocID = UserDefaults.standard.string(forKey: "UserDocumentID")
            let docref = firebaseRef.collection(Constants.UserDetails.userDetailsCollectionPath).document(userDocID!).collection(Constants.Diary.diaryCollectionPath).document(documentID)
            do {
                try docref.setData(from: userDiary)
                handler(.success(true))
            } catch {
                handler(.failure(.firebaseError(error)))
            }
        }
    } // Update
    
    
    //    func deleteDiary(userDeleteDiary deleteDiary: Diary, completion: @escaping (Result<Bool, FirebaseError>) -> Void) {
    //        let firebaseRef = Firestore.firestore()
    //        firebaseRef.collection("UserDetails").document().collection("Diary")
    //        firebaseRef.document(deleteDiary.id!).delete() { error in
    //            if let error {
    //                completion(.failure(.firebaseError(error)))
    //            }
    //            completion(.success(true))
    //        }
    //    }
    
    //    func deleteDiary(userDeleteDiary diary: Diary, completion: @escaping (Result<Bool, FirebaseError>) -> Void) {
    //        let firebaseRef = Firestore.firestore()
    //        let diaryID = diary.id
    //        firebaseRef.collection("UserDetails").document(diary.id!).collection("Diary").document(diaryID!).delete() { error in
    //            if let error {
    //                completion(.failure(.firebaseError(error)))
    //            }
    //            completion(.success(true))
    //        }
    //    }
    
    func deleteDiary(userDeleteDiary deleteDiary: Diary, completion: @escaping (Result<Bool, FirebaseError>) -> Void) {
        let firebaseRef = Firestore.firestore()
        let diaryID = deleteDiary.id
        let userDocID = UserDefaults.standard.string(forKey: "UserDocumentID")
        firebaseRef.collection("UserDetails").document(userDocID!).collection("Diary").document(diaryID!).delete() { error in
            if let error {
                completion(.failure(.firebaseError(error)))
            }
            completion(.success(true))
        }
    } // end of delete Diary
    
} //end of struct

