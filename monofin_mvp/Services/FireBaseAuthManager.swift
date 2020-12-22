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
    func signIn(email: String, password: String, completionBlock: @escaping (Result<Bool, Error>) -> Void)
    func deleteUser(completionBlock: @escaping (Result<Bool, Error>) -> Void)
    func checkCurenUser(email: String, password: String, uid: String, completionBlock: @escaping(Result<Bool,Error>) -> Void)
    func changePassword(newPassword: String, completionBlock: @escaping(Result<Bool,Error>) -> Void)
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
                            UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "uid")
                            completionBlock(.success(true))
                        }
                    }
                }
            }
        }
    }
    
    func signIn(email: String, password: String, completionBlock: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completionBlock(.failure(error))
                return
            } else {
                UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "uid")
                completionBlock(.success(true))
            }
        }
    }
    
    func checkCurenUser(email: String, password: String, uid: String, completionBlock: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completionBlock(.failure(error))
                return
            } else {
                if let currentUserUid = Auth.auth().currentUser?.uid {
                    if currentUserUid == UserDefaults.standard.value(forKey: "uid") as! String {
                        completionBlock(.success(true))
                        
                    } else {
                        completionBlock(.success(false))
                    }
                }
            }
            
            
        }
    }
    
    func deleteUser(completionBlock: @escaping (Result<Bool, Error>) -> Void) {
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                completionBlock(.failure(error))
                return
            } else {
                UserDefaults.standard.set(nil, forKey: "uid")
                completionBlock(.success(true))
            }
            
        }
    }
    
    func changePassword(newPassword: String, completionBlock: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { (error) in
            if let error = error {
                completionBlock(.failure(error))
            } else {
                completionBlock(.success(true))
            }
            
        })
    }
    
}
