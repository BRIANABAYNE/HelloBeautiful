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
    private let service: FirebaseServiceable
    weak var delegate: UserSettingsViewModelDelegate?
    
    // MARK: - Dependenct Injections
    init(service:FirebaseServiceable = FirebaseService(), delegate: UserSettingsViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signoutError as NSError {
            print("Error signing out", signoutError)
        }
    }
    
    
    
}
