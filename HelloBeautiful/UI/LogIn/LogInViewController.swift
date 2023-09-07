//
//  LogInViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/27/23.
//

import UIKit
import AuthenticationServices
import CryptoKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    
    //MARk: - Outlets
    @IBOutlet weak var logInEmaiTextField: UITextField!
    @IBOutlet weak var logInPasswordTextField: UITextField!
    
    // MARK: - Properties
    var viewModel:LogInViewModel!
    
    fileprivate var currentNonce: String?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LogInViewModel(delegate: self)
        signInWithApple()
        
        // call the function appleIDStateRevoked if user revoke the sign in in Settings app
        
        NotificationCenter.default.addObserver(self, selector: #selector(appleIDStateRevoked), name: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil)
    }
    
    // MARK: - Method
    
    func signInWithApple() {
        let siwaButton = ASAuthorizationAppleIDButton()
        
        // set this so the button will use auto layout constraint
        siwaButton.translatesAutoresizingMaskIntoConstraints = false
        
        // add the button to the view controller root view
        self.view.addSubview(siwaButton)
        
        // set constraint
        NSLayoutConstraint.activate([
            siwaButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50.0),
            siwaButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50.0),
            siwaButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70.0),
            siwaButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        // the function that will be executed when user tap the button
        siwaButton.addTarget(self, action: #selector(appleSignInTapped), for: .touchUpInside)
        
    }
    @objc func appleSignInTapped() {
        //        let provider = ASAuthorizationAppleIDProvider()
        //        let request = provider.createRequest()
        //        // request full name and email from the user's Apple ID
        //        request.requestedScopes = [.fullName, .email]
        //
        //        // pass the request to the initializer of the controller
        //        let authController = ASAuthorizationController(authorizationRequests: [request])
        //
        //        // similar to delegate, this will ask the view controller
        //        // which window to present the ASAuthorizationController
        //        authController.presentationContextProvider = self
        //
        //        // delegate functions will be called when user data is
        //        // successfully retrieved or error occured
        //        authController.delegate = self
        //
        //        // show the Sign-in with Apple dialog
        //        authController.performRequests()
        
        
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        
    }
    
    @objc func appleIDStateRevoked() {
        // log out user, change UI etc
    }
    
    // MARK: - Function SignInWithApple
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
            // Pick a random character from the set, wrapping around if needed.
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
    
    
    // MARK: - Actions
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        guard let email = logInEmaiTextField.text,
              let password = logInPasswordTextField.text  else { return }
        viewModel.signIn(with: email, password: password)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logIn = storyboard.instantiateViewController(identifier:"tabBar")
        self.view.window?.rootViewController = logIn
        
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        //TODO: - FINISH THIS
        
    }
    
}

// MARK: Extensions
extension LogInViewController: LogInViewModelDelegate {
    func encountered(_ error: Error) {
        // TODO: - Present Alert
    }
}
// MARK: - Extension
extension LogInViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // return the current view window
        return self.view.window!
    }
}

// MARK: - Extension
extension LogInViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("authorization error")
        guard let error = error as? ASAuthorizationError else {
            return
        }
        switch error.code {
        case .canceled:
            // user press "cancel" during the login prompt
            print("Canceled")
        case .unknown:
            // user didn't login their Apple ID on the device
            print("Unknown")
        case .invalidResponse:
            // invalid response received from the login
            print("Invalid Respone")
        case .notHandled:
            // authorization request not handled, maybe internet failure during login
            print("Not handled")
        case .failed:
            // authorization failed
            print("Failed")
        @unknown default:
            print("Default")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userID = appleIDCredential.user
            
            // use the user credential / data to do stuff here ...
            // save it to user defaults
            
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            UserDefaults.standard.set(appleIDCredential.user, forKey: "userID")
            
            // Initialize a Firebase credential, including the user's full name.
            let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                           rawNonce: nonce,
                                                           fullName: appleIDCredential.fullName)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    print(error.localizedDescription)
                    return
                }
                // User is signed in to Firebase with Apple.
                // ...
            }
        }
    }
}
