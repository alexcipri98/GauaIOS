//
//  AuthService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 18/10/23.
//

import Foundation
import FirebaseAuth

struct AuthService: AuthServiceProtocol {
    
    public func logout() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            print("Error al cerrar sesión: \(error)")
            return false
        }
    }
    
    public func currentUserExist() -> UserAuthType? {
        guard let user = Auth.auth().currentUser else { return nil }
        for info in user.providerData {
            if info.providerID == "phone" {
                return .userClient
            } else if info.providerID == "password" {
                return .userPub
            }
        }
        return nil
    }
    
    public func signInCode(verificationCode: String, onSuccess: @escaping () -> Void, onFailure: @escaping (Error?) -> Void) {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                onFailure(error)
            } else {
                print("Autenticación exitosa en AuthService" + (authResult?.user.phoneNumber ?? ""))
                onSuccess()
            }
        }
    }
    
    public func signInEmail(email: String, password: String, onSuccess: @escaping () -> Void, onFailure: @escaping (Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                onFailure(error)
            }
            print("Inicio de sesión exitoso")
            onSuccess()
        }
    }
    
    public func getVerificationID(prefix: String, phoneNumber: String, onSuccess: @escaping (String) -> Void, onFailure: @escaping (Error?) -> Void) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(prefix + phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error.localizedDescription)
                    onFailure(error)
                } else {
                    if let verificationID = verificationID {
                        print("this is the verification id" + verificationID)

                        onSuccess(verificationID)
                    } else {
                        onFailure(nil)
                    }
                }
            }
    }
}
