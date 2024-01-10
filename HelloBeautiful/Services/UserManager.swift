//
//  UserManager.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 12/1/23.
//

import FirebaseAuth
import Foundation

class UserManager {
    
    static let shared = UserManager()
    
    private init() {
        setupUserStateListener()
    }
    
    private(set) var currentUser: FirebaseAuth.User?
    var handle: AuthStateDidChangeListenerHandle?
    var userStateDidChange: ((FirebaseAuth.User?) -> Void)?
    
    private func setupUserStateListener() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            self?.userStateDidChange?(user)
        }
    }
}
