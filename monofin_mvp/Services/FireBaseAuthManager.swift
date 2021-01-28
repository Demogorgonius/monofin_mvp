//
//  FireBaseAuthManager.swift
//  monofin_mvp
//
//  Created by Sergey on 07.12.2020.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

protocol FireBaseInputProtocol {
    func createUser(userName: String, email: String, password: String, completionBlock: @escaping (Result<UserInfo, Error>) -> Void)
    func signIn(email: String, password: String, completionBlock: @escaping (Result<UserInfo, Error>) -> Void)
    func deleteUser(completionBlock: @escaping (Result<Bool, Error>) -> Void)
    func checkCurenUser(email: String, password: String, uid: String, completionBlock: @escaping(Result<Bool,Error>) -> Void)
    func changePassword(newPassword: String, completionBlock: @escaping (Result<Bool,Error>) -> Void)
    func rememberPassword(email: String, complitionBlock: @escaping (Result<Bool,Error>) -> Void)
    func userUpdateProfileImage(image: UIImage, completionBlock: @escaping(Result<Bool, Error>) -> Void)
    func getUserProfile(completionBlock: @escaping(Result<UserInfo, Error>) -> Void)
}

class FireBaseAuthManager: FireBaseInputProtocol {
    
    func createUser(userName: String, email: String, password: String, completionBlock: @escaping (Result<UserInfo, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completionBlock(.failure(error))
                return
            } else {
                var user: UserInfo!
                if let currentUser = Auth.auth().currentUser?.createProfileChangeRequest() {
                    currentUser.displayName = userName
                    currentUser.commitChanges { (error) in
                        if let error = error {
                            completionBlock(.failure(error))
                        } else {
                            
                            UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "uid")
                            if let curUser = Auth.auth().currentUser {
                                user = UserInfo(userName: curUser.displayName ?? "naname",
                                                uid: curUser.uid,
                                                email: curUser.email!,
                                                photoURL: curUser.photoURL)
                            }
                            completionBlock(.success(user))
                        }
                    }
                }
            }
        }
    }
    
    func signIn(email: String, password: String, completionBlock: @escaping (Result<UserInfo, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completionBlock(.failure(error))
                return
            } else {
                UserDefaults.standard.set(Auth.auth().currentUser?.uid, forKey: "uid")
                var user: UserInfo!
                if let currentUser = Auth.auth().currentUser {
                    
                    user = UserInfo(userName: currentUser.displayName ?? "noname",
                                    uid: currentUser.uid,
                                    email: currentUser.email!,
                                    photoURL: currentUser.photoURL)
                    
                }
                completionBlock(.success(user))
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
    
    func rememberPassword(email: String, complitionBlock: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                complitionBlock(.failure(error))
            } else {
                complitionBlock(.success(true))
            }
        }
    }
    
    func userUpdateProfileImage(image: UIImage, completionBlock: @escaping (Result<Bool, Error>) -> Void) {
        
    }
    
    func getUserProfile(completionBlock: @escaping (Result<UserInfo, Error>) -> Void) {
        let currentUser = Auth.auth().currentUser
        currentUser?.reload(completion: { (error) in
            if let error = error {
                completionBlock(.failure(error))
            } else {
                var user: UserInfo!
                if let curUser = Auth.auth().currentUser {
                    user = UserInfo(userName: curUser.displayName ?? "noname",
                                    uid: curUser.uid,
                                    email: curUser.email!,
                                    photoURL: curUser.photoURL)
                }
                completionBlock(.success(user))
            }
        })
    }
    
}
