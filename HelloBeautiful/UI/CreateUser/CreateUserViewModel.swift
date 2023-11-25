//
//  CreateUserViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/28/23.
//

import Foundation

// MARK: - Protocol
protocol CreateUserViewModelDelegate: CreateUserDetailViewController {
    func encountered(_ error: Error)
}

struct CreateUserViewModel {
    
    // MARK: - Properties
    private let service: FirebaseAuthServiceable
    weak var delegate: CreateUserViewModelDelegate?
    var userInfoToSendInSegue: UserDetails?
    
    // MARK: - Dependency Injection
    init(service: FirebaseAuthServiceable = FirebaseAuthService(), delegate: CreateUserViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    // MARK: - Functions
    func createAccount(with email: String, password: String, confirmPassword: String) {
        if password == confirmPassword {
            service.createAccount(with: email, password: password, confirmPassword: confirmPassword) { result in
                switch result {
                case .success(_):
                    print("User was created successfully")
#warning("Should we only change the UI if signing in was successful??")
                case .failure(let failure):
                    print("User was not created")
                    delegate?.encountered(failure)
                }
            }
        } else {
            delegate?.encountered(CreateAccountError.passwordMismatch)
        }
    }
}
