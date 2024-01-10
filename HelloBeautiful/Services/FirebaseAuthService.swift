//
//  FirebaseService.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/27/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestoreSwift

protocol FirebaseAuthServiceable {
    func createAccount(
        with email: String,
        password: String,
        completion: @escaping(Result<Bool, CreateAccountError>) -> Void)
    func signIn(
        email: String,
        password: String,
        completion: @escaping(Result<Bool, CreateAccountError>) -> Void)
    func signOut()
    func delete()
    func update(userDetails: User)
    func save(userDetails: User, completion: @escaping(Result<String, FirebaseError>) -> Void)
}

struct FirebaseAuthService: FirebaseAuthServiceable {
    
    func createAccount(
        with email: String,
        password: String,
        completion: @escaping(Result<Bool, CreateAccountError>) -> Void)
    {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                completion(.failure(.firebaseError(error)))
            }
            
            let userAuthID = authResult?.user.uid
            UserDefaults.standard.set(userAuthID, forKey: "UserAuthID")
            completion(.success(true))
        }
    }
    
    func signIn(
        email: String,
        password: String,
        completion: @escaping(Result<Bool, CreateAccountError>) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                completion(.failure(.firebaseError(error)))
                return
            }
            
            let userAuthID = authResult?.user.uid
            UserDefaults.standard.set(userAuthID, forKey: "UserAuthID")
            DispatchQueue.main.async {
                completion(.success(true))
            }
        }
    }
    
    func signOut() {
        do {
            UserDefaults.standard.removeObject(forKey: "UserAuthID")
            try Auth.auth().signOut()
            print("signingout")
        } catch let signOutError as NSError {
            print("Error signing out", signOutError)
        }
    }
    
    
    func delete() {
#warning("Finish this")
        let userDetails = Auth.auth().currentUser
        userDetails?.delete { error in
            if let error = error {
                
            } else {
                
            }
        }
    }
    
    func save(
        userDetails: User,
        completion: @escaping(Result<String, FirebaseError>) -> Void ) {
            let ref = Firestore.firestore()
            do {
                let documentRef = try ref
                    .collection(Constants.User.userDetailsCollectionPath)
                    .addDocument(from: userDetails, completion: { _ in
                    })
                
                UserDefaults.standard.set(documentRef.documentID, forKey: "UserDocumentID")
                completion(.success(documentRef.documentID))
            } catch {
                print("Oh no, something went wrong with the save", error.localizedDescription)
                return
            }
        }
    
    func update(userDetails: User) {
        if let documentID = userDetails.id {
            let ref = Firestore.firestore()
            let docRef = ref.collection(Constants.User.userDetailsCollectionPath).document(documentID)
            
            do {
                try docRef.setData(from: userDetails)
            } catch {
                print(error)
            }
        }
    }
}


