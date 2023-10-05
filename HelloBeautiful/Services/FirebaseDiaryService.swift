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

protocol FirebaseDiaryServicable {
   
    func updateDiary(userDiary: Diary, handler: @escaping (Result<Bool, FirebaseError>) -> Void)
    func saveDiary(userDiary: Diary, completion: @escaping(Result<String, FirebaseError>) -> Void)
}

struct FirebaseDiaryService: FirebaseDiaryServicable {
    
    func saveDiary(userDiary: Diary, completion: @escaping (Result<String, FirebaseError>)-> Void) {
        let firebaseRef = Firestore.firestore()
        do {
            let userDocID = UserDefaults.standard.string(forKey: "UserDocumentID")
            let documentFeelingsRef = try
            firebaseRef.collection(Constants.UserDetails.userDetailsCollectionPath).document(userDocID!).collection(Constants.Diary.diaryCollectionPath).addDocument(from: userDiary, completion: { _ in
                
            })
            
            completion(.success(documentFeelingsRef.documentID))
        } catch {
            print("Oh no, something went wrong with the saving the Diary", error.localizedDescription)
            return
        }
    } // end of save
    

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
    
    
    
    
    
    
    
    
    
    
} //end of struct
