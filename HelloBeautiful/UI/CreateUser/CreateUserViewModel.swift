//
//  CreateUserViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/28/23.
//



import Foundation


protocol CreateUserViewModelDelegate: CreateUserDetailViewController {
    func encountered(_ error: Error)
}
struct CreateUserViewModel {
    
    // MARK: - Properties
    private let service: FirebaseAuthServiceable
    weak var delegate: CreateUserViewModelDelegate?
    
    // MARK: - Dependency Injection
    init(service: FirebaseAuthServiceable = FirebaseAuthService(), delegate: CreateUserViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func createAccount(with email: String, password: String, confirmPassword: String) {
        if password == confirmPassword {
            service.createAccount(with: email, password: password, confirmPassword: confirmPassword) { result in
                switch result {
                case .success(_):
                    print("User was created successfully")
                case .failure(let failure):
                    print("User was not created")
                    delegate?.encountered(failure)
                }
            }
        } else {
            delegate?.encountered(CreateAccountError.passwordMismatch)
        }
    } // end of create 
} // end of viewModel
    


    
    
