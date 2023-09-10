//
//  LogInViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/27/23.
//

import Foundation
import FirebaseAuth


protocol LogInViewModelDelegate: LogInViewController {
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
    
    // MARK: - Methods
    func signIn(with email: String, password: String) {
    
        service.signIn(email: email, password: password) { result  in
            switch result {
            case .success(_):
                print("User logged in")
                #warning("Perhapes we should only change the screen if logging in was successful... Which means you'll need a way to communciate that it was successful to the VC")
            case .failure(let failure):
                delegate?.encountered(failure)
            }
        }
        
    } // sign in
    
} // log in
