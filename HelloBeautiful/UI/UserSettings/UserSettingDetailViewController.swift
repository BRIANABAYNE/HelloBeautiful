//
//  UserSettingDetailViewController.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 8/1/23.
//

import UIKit
import FirebaseAuth
import AuthenticationServices
import CryptoKit

class UserSettingDetailViewController: UIViewController, UserSettingsViewModelDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var zodiacSignLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userCycleLength: UILabel!
    @IBOutlet weak var userPeriodLength: UILabel!
    @IBOutlet weak var logOutButon: BBButton!
    @IBOutlet weak var deleteAccountButton: BBButton!
    
    
    // MARK: - Properties
    
    var viewModel: UserSettingsViewModel!
//    private let newUserContainer: NewUser?
   
    
    fileprivate var currentNonce: String?
    #warning("Should I create a new string here??")
   
    
    
    var zodiacSign: String!
    var userEmail: String!
    var cycleLength: Int!
    var lastCycleDate: Date!
    
    
    
//    init?(newUserContainer: NewUser, coder: NSCoder) {
//        self.newUserContainer = newUserContainer
//        super.init(coder: coder)
//    }
//    
//    @available(*, unavailable, renamed: "init(newUserContainer:coder:)")
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//     MARK: - Function
    
//    private func configureView() {
//        guard let newContainer = newUserContainer else {return}
//        userEmailLabel.text = newContainer.email
//        userCycleLength.text = "\(newContainer.cycleLength)"
//        userPeriodLength.text =  "\(newContainer.lastCycleStartDate)"
//    }
    
    
    
    // MARK: - LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = UserSettingsViewModel(delegate: self)
//        configureView()
        logOutButon.set(title: "Log Out", systemImageName: "")
        deleteAccountButton.set(title: "Delete Account", systemImageName: "")
    }
    
    // MARK: - Actions
    
    @IBAction func deleteAccountButtonTapped(_ sender: Any) {
        presentDeleteAccountAlert()
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        presentLogOutAlert()
    }
    
   //  MARK: - Delete Account Apple
    
//    typealias ActionWithNewCredentials = (OAuthCredential) -> Void
//    var pendingAction: ActionWithNewCredentials?
//    
//    private func deleteAccount() {
//        let user = Auth.auth().currentUser
//    
//    user?.delete { [weak self] error in
//        guard let strongSelf = self else { return }
//        
//        if let errorCode = error?._code, let authErrorCode = AuthErrorCode(rawValue: errorCode)
//{
//            switch authErrorCode {
//            case .requiresRecentLogin:
//                print("Requires recent login")
//                strongSelf.reauthenticateThenDelete()
//            default:
//                break
//            }
//        } else {
//            strongSelf.pendingAction = nil
//            print("Deleted Apple Account")
//        }
//    }
//}
//    private func reauthenticateThenDelete() {
//        pendingAction = { [weak self] credential in
//            Auth.auth().currentUser?.reauthenticate(with: credential) { (authResult, error) in
//                guard error == nil else { return }
//                self?.deleteAccount()
//            }
//        }
//        
//        startSignInWithAppleFLow()
//    }
//    
//    private func randomNonceString(length: Int = 32) -> String {
//        precondition(length > 0)
//        var randomBytes = [UInt8](repeating: 0, count: length)
//        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
//        if errorCode != errSecSuccess {
//            fatalError(
//                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
//            )
//        }
//        
//        let charset: [Character] =
//        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
//        let nonce = randomBytes.map { byte in
//            charset[Int(byte) % charset.count]
//        }
//        
//        return String(nonce)
//    }
//    
//    @available(iOS 13, *)
//    private func sha256(_ input: String) -> String {
//        let inputData = Data(input.utf8)
//        let hashedData = SHA256.hash(data: inputData)
//        let hashString = hashedData.compactMap {
//            String(format: "%02x", $0)
//        }.joined()
//        return hashString
//    }
//    
//    
//    private func startSignInWithAppleFLow() {
//        let nonce = randomNonceString()
//        currentNonce = nonce
//        
//        let appleIDProvider = ASAuthorizationAppleIDProvider()
//        let request = appleIDProvider.createRequest()
//        request.requestedScopes = [.fullName, .email]
//        request.nonce = sha256(nonce)
//        
//        let authorizationController = ASAuthorizationController(authorizationRequests:[request])
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
//    }
//    
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            guard let nonce = currentNonce else {
//                fatalError("Invalid state: A login callback was received, but no login request was sent.")
//            }
//            
//            guard
//                let appleIDToken = appleIDCredential.identityToken,
//                let idTokenString = String(data: appleIDToken, encoding: .utf8)
//            else {
//                print("Unable to read identityToken")
//                return
//            }
//            
//            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
//            if let pendingAction = pendingAction {
//                pendingAction(credential)
//            } else {
//                Auth.auth().signIn(with: credential) { (authResult, error) in
//                    
//                }
//            }
//        }
//    }
//    
    
    // MARK: - Helper Function
    
    func changeUI() {
        let storyboard = UIStoryboard(name:"LogIn", bundle: nil)
        let login = storyboard.instantiateViewController(identifier:"LogIn")
        self.view.window?.rootViewController = login
    }
    
    // MARK: - Alert
    
    func presentDeleteAccountAlert() {
        let alertController = UIAlertController(
            title: "Delete Account?" ,
            message: "Are you sure you want to delete your account? This action cannot be undone!",
            preferredStyle: .alert
        )
        
        let noAction = UIAlertAction(
            title: "Dismiss",
            style: .default)
        print("Action Taken: Dismiss")
        let yesAction = UIAlertAction(
            title: "Delete Account",
            style: .destructive) { [self] _ in
            print("Action Taken: Delete List")
            self.viewModel.delete()
            self.changeUI()
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true)
    }
    
    func presentLogOutAlert() {
        let alertController = UIAlertController(
            title: "Log Out?" ,
            message: "Are you sure you want to log out?",
            preferredStyle: .alert)
        let noAction = UIAlertAction(title: "Dismiss", style: .default)
        print("Action Taken: Dismiss")
        let yesAction = UIAlertAction(
            title: "Log Out", style: .destructive) { [self] _ in
            print("Action Taken: Delete List")
            self.viewModel.signOut()
            self.changeUI()
        }
        
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true)
    }
    
}

// MARK: - Extension

//extension UserSettingDetailViewController {
//    static func create(with newUser: NewUser) ->
//    UserSettingDetailViewController {
//        let storyboard = UIStoryboard(name: "UserSettings", bundle: nil)
//        return
//        storyboard.instantiateViewController(identifier: "UserSetting") { coder in
//            UserSettingDetailViewController(newUserContainer: newUser, coder: coder)
//        }
//    }
//}
