//
//  CreateUserViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/28/23.
//

import Foundation
//
//  CreateUserViewModel...swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/28/23.
//

import Foundation
import FirebaseAuth

protocol CreateUserViewModelDelegate: CreateUserDetailViewController {
    func encountered(_ error: Error)
}
struct CreateUserViewModel {
    
    // MARK: - Properties
    private let service: FirebaseServiceable
    weak var delegate: CreateUserViewModelDelegate?
    
    // MARK: - Dependency Injection
    init(service: FirebaseServiceable = FirebaseService(), delegate: CreateUserViewModelDelegate) {
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
                    delegate?.encountered(failure)
                }
            }
        } else {
            delegate?.encountered(CreateAccountError.passwordMismatch)
        }
        
        
//        func signIn(with email: String, password: String, confirmPassword: String ) {
//
//            if password == confirmPassword {
//                service.signIn(email: email, password: password) { result  in
//                    switch result {
//                    case .success(_):
//                        print("User was created successfully")
//                    case .failure(let failure):
//                        delegate?.encountered(failure)
//                    }
//
//                }
//
//
//            }
//            delegate?.encountered(CreateAccountError.passwordMismatch)
//
//        } // sign in
        
        
    }
} // end of viewModel
    
//    func create(firstName: String, lastName: String, email: String, password: String, lastCycle: String, periodLength: Int, zodiacSign: String, completion: @escaping(Result<String,FirebaseError>) -> Void) {
//        let user = User(firstName: firstName, lastName: lastName, email: email, password: password, zodiacSign: zodiacSign, lastCycle: lastCycle , collectionType: Constants.User.userCollectionPath)
//    }
//
//    func updateUser() {
//
//    }
//
//
//
//    func update(user: User) {
//        if let documentID = user.id {
//            let ref = Firestore.firestore()
//            let docRef = ref.collection(Constants.User.userCollectionPath).document(documentID)
//
//            do {
//                try docRef.setData(from: user)
//            } catch {
//                print(error)
//            }
//        }
//
//
//        func save() {
//
//        }
//
//        func fetchAllUsers() {
//
//        }
//
//        func deleteUser() {
//
//        }
//    }
//
    
    
