//
//  LoginViewModel.swift
//  Photo Editor
//
//  Created by Igor on 17.04.2024.
//

import Foundation
import Firebase
import GoogleSignIn

class AuthorizationViewModel: ObservableObject {
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    @Published var state: SignInState = .signedOut
    
    func signInWithGoogle() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticate(for: user, with: error)
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            let configuration = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = configuration
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] result, error in
                authenticate(for: result?.user, with: error)
            }
        }
    }

    func signIn(with email: String, password: String) {
        // Вход пользователя
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Ошибка при входе пользователя: \(error.localizedDescription)")
            } else {
                print("Пользователь успешно вошел в систему")
                self.state = .signedIn
            }
        }
    }

    func signUp(with email: String, password: String) {
        // Регистрация пользователя
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Ошибка при регистрации пользователя: \(error.localizedDescription)")
            } else {
                print("Пользователь успешно зарегистрирован")
                self.state = .signedIn
            }
        }
    }

    func resetPassword(with email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error resetting password: \(error.localizedDescription)")
            } else {
                print("Password reset email sent successfully")
            }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            state = .signedOut
            print("SignOut user")
        } catch {
            print(error.localizedDescription)
        }
    }

    func authenticate(for user: GIDGoogleUser?, with error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let user = user,
              let idToken = user.idToken?.tokenString else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: user.accessToken.tokenString)
        
        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                state = .signedIn
                print("SignIn user")
            }
        }
    }
}
