//
//  SignInUpViewModel.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/02/16.
//

import Foundation
import AuthenticationServices
import Firebase
import FirebaseAuth
import GoogleSignIn

import CryptoKit


enum OAuthProviderId {
    case google
    case apple
}

class SignInUpViewModel: NSObject, ObservableObject {
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var showSignInField: Bool = false
    
    private var nonce = ""
    
    
    // MARK: - 1st Methods
    
    func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        nonce = randomNonceString()
        request.nonce = sha256(nonce)
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func signInWithGoogle() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                if let credential = createGoogleCredential(for: user, with: error) {
                    signInWithFirebase(credential: credential)
                }
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            let configuration = GIDConfiguration(clientID: clientID)
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                if let credential = createGoogleCredential(for: user, with: error) {
                    signInWithFirebase(credential: credential)
                }
            }
        }
    }
    
    
    // MARK: - 2nd Methods
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
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
    
    private func createAppleCredential(authorization: ASAuthorization) -> AuthCredential? {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
        else { return nil }
        guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return nil
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return nil
        }
        
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: idTokenString,
                                                  rawNonce: nonce)
        
        return credential
    }
    
    private func createGoogleCredential(for user: GIDGoogleUser?, with error: Error?) -> AuthCredential? {
        if let error = error {
            print(error.localizedDescription)
            return nil
        }
        
        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return nil }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        
        return credential
    }
    
    
    private func signInWithFirebase(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Log -", #fileID, #function, #line, error.localizedDescription)
                return
            }
            print("Log -", #fileID, #function, #line, "User SignIn Success")
        }
    }
    
    
    // MARK: - 3rd Methods
    
    
    
}


extension SignInUpViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = createAppleCredential(authorization: authorization) {
            signInWithFirebase(credential: credential)
        }
    }
}
