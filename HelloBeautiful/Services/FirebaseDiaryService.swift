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
   
//    func fetchDiaryEntries(completion: @escaping(Result<[Diary], FirebaseError>) -> Void)
    func updateDiary(userDiary: Diary, handler: @escaping (Result<Bool, FirebaseError>) -> Void)
    func saveDiary(userDiary: Diary, completion: @escaping(Result<String, FirebaseError>) -> Void)
    func deleteDiary(userDeleteDiary: Diary, completion: @escaping(Result<Bool, FirebaseError>) -> Void)
//    func fetchUserDetails(handler: @escaping (Result<[UserDetails], FirebaseError>) -> Void)
//    func fetchDiary(handler: @escaping(Result<[Diary], FirebaseError>) -> Void)
    
}

struct FirebaseDiaryService: FirebaseDiaryServicable {
    
    

//    func fetchDiaryEntries(completion: @escaping (Result<[Diary], FirebaseError>) -> Void) {
//        let firebaseRef = Firestore.firestore()
//        firebaseRef.collection("UserDetails").document(self.diary).collection("Diary").getDocuments() { snapshot,
//            error in
//            if let error = error {
//                print("Error getting User Docs \(error)")
//            } else {
//                let currentUID: String = Auth.auth().currentUser!.uid
//                let userRef = firebaseRef.collection("Diary").document(currentUID)
//                userRef.getDocument { document, error in
//                    if let document = document, document.exists {
//                        var
//                    }
//
//                }
//            }
//
//        }
//
    
    
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
    
    
//    func fetchUserZodiacSign(){
//
//        let defaultStore = Firestore.firestore()
//        defaultStore.collection("UserDetails").getDocuments { snapshot, error in
//            if let error = error {
//                print("Error getting User Docs \(error)")
//            } else {
//                let currentUID: String = Auth.auth().currentUser!.uid
//                let userRef = defaultStore.collection("UserDetails").document(currentUID)
//                userRef.getDocument { document, error in
//                    if let document = document, document.exists {
//                        var userZodiac: String = ""
//                        if(document.get("zodiacSign") as? String != nil ) {
//                            userZodiac = document.get("zodiacSign") as? String ?? ""
//                            self.lowercaseZodiac = userZodiac.lowercased()
//                            print("\(userZodiac.lowercased())")
//                            self.fetchHoroscope(userSign: self.lowercaseZodiac)
//
//                        }
//                    }
//                }
//            }
//
//        }
    
    
    
    
    
    
    
    
    
//    func fetchAllBags(handler: @escaping (Result<[Diary], FirebaseError>) -> Void) {
//        .getDocuments { snapshot, error in
//            guard let documents = snapshot?.documents else {return}
//            do {
//                let bagsArray = try documents.compactMap({ try $0.data(as: Bag.self)})
//                handler(.success(bagsArray))
//            } catch {
//                handler(.failure(.firebaseError(error)))
//            }
//        }
//    }
    
    
    
//    func fetchDiary(handler: @escaping (Result<[Diary], FirebaseError>) -> Void) {
//        let dbRef = Firestore.firestore().collection(Constants.UserDetails.userDetailsCollectionPath).getDocuments.collection(Constants.Diary.diaryCollectionPath).getDocuments { snapshot, error in
//            guard let documents = snapshot?.documents else {return}
//            do {
//                let bagsArray = try documents.compactMap({ try $0.data(as: Diary.self)})
//                handler(.success(bagsArray))
//            } catch {
//                handler(.failure(.firebaseError(error)))
//            }
//        }
//    }
       
 
    
 
    func saveDiary(userDiary: Diary, completion: @escaping (Result<String, FirebaseError>) -> Void) {
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
    
//    func deleteDiary(deleteDiary: Diary, completion: @escaping(Result<String, FirebaseError>) -> Void) {
//        let firebaseRef = Firestore.firestore()
//        do {
//            let diaryDocID = UserDefaults.standard.string(forKey: "UserDocumentID")
//            let documentDiaryRef = try
//            firebaseRef.collection(Constants.UserDetails.userDetailsCollectionPath).document(diaryDocID!).collection(Constants.Diary.diaryCollectionPath)
//
//
//        }
//
//
//    }

    func deleteDiary(userDeleteDiary: Diary, completion: @escaping(Result<Bool, FirebaseError>) -> Void) {
        let firebaseRef = Firestore.firestore()
        if let documentDiaryID = userDeleteDiary.id {
            let userDiaryID = UserDefaults.standard.string(forKey: "UserDocumendID")
            let documentRef = firebaseRef.collection(Constants.UserDetails.userDetailsCollectionPath).document(userDiaryID!).collection(Constants.Diary.diaryCollectionPath).document(documentDiaryID).delete { error in
                if let error {
                    completion(.failure(.firebaseError(error)))
                }
                completion(.success(true))
            }
        }
        
    }
    

//    func deleteDiary(userDeleteDiary: Diary, completion: @escaping(Result<String, FirebaseError>) -> Void) {
//        let firebaseRef = Firestore.firestore()
//        do {
//            let userDiaryID = UserDefaults.standard.string(forKey: "UserDocumendID")
//            let documentRef = try  firebaseRef.collection(Constants.UserDetails.userDetailsCollectionPath).document(userDiaryID!).collection(Constants.Diary.diaryCollectionPath).delete { _ in
//        })
//       completion(.success(documentRef.id))
//        } catch {
//            print("Oh no, something went wrong with deleting a Diary", error.localizedDescription)
//            return
//        }
//
//    }
    
} //end of struct

