//
//  FirebaseService.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/27/23.
//

import Foundation
import FirebaseAuth

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
}
