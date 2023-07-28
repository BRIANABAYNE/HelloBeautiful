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
    
    private let service: FirebaseServiceable
    weak var delegate: LogInViewModelDelegate?
    
   // MARK: - Dependency Injection
    init(service: FirebaseServiceable = FirebaseService(), delegate: LogInViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
  
    func signIn(with email: String, password: String, confirmPassword: String ) {
 
             if password == confirmPassword {
                 service.signIn(email: email, password: password) { result  in
                     switch result {
                     case .success(_):
                         print("User was created successfully")
                     case .failure(let failure):
                         delegate?.encountered(failure)
                     }
 
                 }
 
 
             }
             delegate?.encountered(CreateAccountError.passwordMismatch)
 
         } // sign in
         
   
} // LogIn
