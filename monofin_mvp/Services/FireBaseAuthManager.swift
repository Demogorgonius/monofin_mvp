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
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void)
}

class FireBaseAuthManager: FireBaseInputProtocol {
    func createUser(email: String, password: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let user = authResult?.user {
                print(user)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
}
