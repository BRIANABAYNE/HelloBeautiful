//
//  FirebaseService.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/27/23.
//

import Foundation
import FirebaseAuth

protocol FirebaseServiceable {
    func createAccount( with email: String, password: String, confirmPassword: String, completion: @escaping(Result<Bool, CreateAccountError>) -> Void)
    func signIn(email: String, password: String, completion: @escaping(Result<Bool, CreateAccountError>) -> Void)
    func signOut()
}

struct FirebaseService: FirebaseServiceable {
  

        func createAccount(with email: String, password: String, confirmPassword: String, completion: @escaping(Result<Bool, CreateAccountError>) -> Void) {
           
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error {
                        completion(.failure(.firebaseError(error)))
                    }
                    completion(.success(true))
         }
        } // created
                               
        
        func signIn(email: String, password: String, completion: @escaping(Result<Bool, CreateAccountError>) -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error {
                    completion(.failure(.firebaseError(error)))
                }
                completion(.success(true))
            }
        } // end of sing in
        
        func signOut() {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signoutError as NSError {
                print("Error signing out", signoutError)
            }
        } // end of sign out
    } // end of struct

