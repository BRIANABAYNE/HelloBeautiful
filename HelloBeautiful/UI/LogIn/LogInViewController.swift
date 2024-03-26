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
    
    // MARK: - Outlets
    
    @IBOutlet weak var emailView: HBTextFieldView!
    @IBOutlet weak var passwordView: HBTextFieldView!
    
    
    // MARK: - Properties
    
    var viewModel: LogInViewModel!
    
    var activityView: UIActivityIndicatorView?
    let backgroundImageView = UIImageView()
    fileprivate var currentNonce: String?
    
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LogInViewModel(delegate: self)
        signInWithApple()
        setBackground()
        NotificationCenter.default.addObserver(
            self, selector: #selector(appleIDStateRevoked),
            name: ASAuthorizationAppleIDProvider.credentialRevokedNotification,
            object: nil)
        emailView.set(placeholder: "Email")
        passwordView.set(placeholder: "Password")
        createDismissKeyboardTapGesture()
    }
    
    // MARK: - Dissmiss Keyboard
  
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    

    // MARK: - Methods
    
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.image = UIImage(named: "Brianab")
        view.sendSubviewToBack(backgroundImageView)
    }
    
    func signInWithApple() {
        let signInAppleButton = ASAuthorizationAppleIDButton()
        signInAppleButton.cornerRadius = 20
        signInAppleButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signInAppleButton)
        NSLayoutConstraint.activate([
            signInAppleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0),
            signInAppleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40.0),
            signInAppleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -140.0),
            signInAppleButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        signInAppleButton.addTarget(self, action: #selector(appleSignInTapped), for: .touchUpInside)
    }
    
    @objc func appleSignInTapped() {
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
        guard let email = emailView.text,
              let password = passwordView.text  else { return }
        if(!email.isEmpty && !password.isEmpty) {
            showActivityIndicator()
            viewModel.signIn(with: email, password: password) {
                success in
                if success == false {
                    self.hideActivityIndicator()
                }
            }
        } else {
            showAlert(message:"Enter both Email and Password")
        }
    }
    
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        //TODO: - FINISH THIS
        
    }
    
    // MARK: - Functions
    
    func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Warning!",
            message: message,
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(title: "Ok",
                          style: UIAlertAction.Style.default,
                          handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.hidesWhenStopped = true
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator() {
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
}

// MARK: Extensions

extension LogInViewController: LogInViewModelDelegate {
    func encountered(_ error: Error) {
        showAlert(message: error.localizedDescription)
    }
    
    func success(userDetails: User) {
        self.hideActivityIndicator()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logIn = storyboard.instantiateViewController(identifier:"tabBar")
        self.view.window?.rootViewController = logIn
    }
}

extension LogInViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension LogInViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("authorization error")
        guard let error = error as? ASAuthorizationError else {
            return
        }
        
        switch error.code {
        case .canceled:
            print("Canceled")
        case .unknown:
            print("Unknown")
        case .invalidResponse:
            print("Invalid Respone")
        case .notHandled:
            print("Not handled")
        case .failed:
            print("Failed")
        @unknown default:
            print("Default")
        }
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userID = appleIDCredential.user
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
            let credential = OAuthProvider.appleCredential(
                withIDToken: idTokenString,
                rawNonce: nonce,
                fullName: appleIDCredential.fullName
            )
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                print("User Signed In With Apple To Firebase.")
            }
        }
    }
}

//extension LogInViewController: UITextFieldDelegate {
//    
//}
