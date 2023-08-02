//
//  UserSettingsViewModel.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/1/23.
//

import Foundation
import FirebaseAuth
import UIKit

protocol UserSettingsViewModelDelegate: UserSettingDetailViewController {
    
}

struct UserSettingsViewModel {
    
    
    // MARK: - Properties
    var window: UIWindow?
    var userDetails: UserDetails?
    var user: User?
    private let service: FirebaseServiceable
    weak var delegate: UserSettingsViewModelDelegate?
    
    // MARK: - Dependenct Injections
    init(service:FirebaseServiceable = FirebaseService(), delegate: UserSettingsViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func signOut() {
        service.signOut()
    }
    
    
    // Delete User 
//    let userDetails = Auth.auth().currentUser
//
//    userDetails?.delete { error in
//      if let error = error {
//        // An error happened.
//      } else {
//        // Account deleted.
//      }
//    }
    
    
    
}
