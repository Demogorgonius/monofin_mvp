//
//  FireBaseAuthManager.swift
//  monofin_mvp
//
//  Created by Sergey on 07.12.2020.
//

import Foundation
import FirebaseAuth
import Firebase

protocol FireBaseInputProtocol {
    func createUser(userName: String, email: String, password: String, completionBlock: @escaping (Result<Bool, Error>) -> Void)
}

class FireBaseAuthManager: FireBaseInputProtocol {
    func createUser(userName: String, email: String, password: String, completionBlock: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completionBlock(.failure(error))
                return
            } else {
            
                if let currentUser = Auth.auth().currentUser?.createProfileChangeRequest() {
                    currentUser.displayName = userName
                    currentUser.commitChanges { (error) in
                        if let error = error {
                            completionBlock(.failure(error))
                        } else {
                            completionBlock(.success(true))
                        }
                    }
                }
            }
        }
    }
}
