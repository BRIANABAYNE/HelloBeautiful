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






struct FirebaseDiaryService {
    
    func saveDiary(userDiary: Diary, completion: @escaping (Result<String, FirebaseError>)-> Void) {
        let firebaseRef = Firestore.firestore()
        do {
            let documentFeelingsRef = try
            firebaseRef.collection(Constants.Diary.diaryCollectionPath).addDocument(from: userDiary, completion: { _ in
                
            })
            
            UserDefaults.standard.set(documentFeelingsRef, forKey: "DiaryDocumentID")
            completion(.success(documentFeelingsRef.documentID))
        } catch {
            print("Oh no, something went wrong with the saving the Diary", error.localizedDescription)
            return
        }
    } // end of save
    
    func updateDiary(userDiary: Diary) {
        if let documentDiaryID = userDiary.diaryID {
            let firebaseRef = Firestore.firestore()
            let docRef =
            firebaseRef.collection(Constants.Diary.diaryCollectionPath)
            .document(documentDiaryID)
            
            do {
                try docRef.setData(from: userDiary)
            } catch {
                print(error)
            }
    
        }
    } // end of update
    
    
    
    
    
    
    
    
    
    
    
    
} //end of struct
