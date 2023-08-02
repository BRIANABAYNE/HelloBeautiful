//
//  LogInViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/27/23.
//

import Foundation
import FirebaseAuth


protocol LogInViewModelDelegate: LogInViewController {
    func encountered(_ error: Error)
}

struct LogInViewModel {
    
    
    // MARK: - Properties
    
    private let service: FirebaseAuthServiceable
    weak var delegate: LogInViewModelDelegate?
    
   // MARK: - Dependency Injection
    init(service: FirebaseAuthServiceable = FirebaseAuthService(), delegate: LogInViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
  
    func signIn(with email: String, password: String) {
 
                 service.signIn(email: email, password: password) { result  in
                     switch result {
                     case .success(_):
                         print("User logged in")
                     case .failure(let failure):
                         delegate?.encountered(failure)
                     }
                 }

             } // sign in
 
         } // log in
