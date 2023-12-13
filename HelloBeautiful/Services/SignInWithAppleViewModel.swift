//
//  SignInWithAppleService.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 12/5/23.
//

//import Foundation
import AuthenticationServices
import CryptoKit
import FirebaseAuth

struct SignInWithAppleViewModel {
    
    
    // MARK: - Properties
    
    
    fileprivate var currentNonce: String?
    

  // MARK: - Functions
    
        private func randomNonceString(length: Int = 32) -> String {
            precondition(length > 0)
            var randomBytes = [UInt8](repeating: 0, count: length)
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
            if errorCode != errSecSuccess {
                fatalError(
                    "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                )
            }
    
            let charset: [Character] =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
            let nonce = randomBytes.map { byte in
                charset[Int(byte) % charset.count]
            }
    
            return String(nonce)
        }
    
        @available(iOS 13, *)
        private func sha256(_ input: String) -> String {
            let inputData = Data(input.utf8)
            let hashedData = SHA256.hash(data: inputData)
            let hashString = hashedData.compactMap {
                String(format: "%02x", $0)
            }.joined()
            return hashString
        }

}
