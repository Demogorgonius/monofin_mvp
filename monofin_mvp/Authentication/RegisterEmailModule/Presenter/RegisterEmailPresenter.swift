//
//  RegisterEmailPresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 08.12.2020.
//

import Foundation
import UIKit

protocol RegisterEmailInputProtocol: class {
    func success()
    func failure(error: Error)
}

protocol RegisterEmailOutputProtocol: class {
    init(view: RegisterEmailInputProtocol, router: RouterOutputProtocol, alert: AlertOutputProtocol, firebaseAuthManager: FireBaseInputProtocol)
    func registerTap(userName: String, email: String, password: String)
    func inputCheck(userName: String, email: String, password: String, passwordConform: String) throws -> Bool
    func toMainScreenIfSuccess()
    var userInfo: UserInfo? { get set }
}

class RegisterEmailPresenter: RegisterEmailOutputProtocol {
    
    weak var view: RegisterEmailInputProtocol?
    var router: RouterOutputProtocol?
    var alert: AlertOutputProtocol?
    
    // ||||||| next string ||||||||| Check it |||||||||||||
    
    var firebaseAuthManager: FireBaseInputProtocol?
    
    var userInfo: UserInfo?
    
    
    required init(view: RegisterEmailInputProtocol, router: RouterOutputProtocol, alert: AlertOutputProtocol, firebaseAuthManager: FireBaseInputProtocol) {
        self.view = view
        self.router = router
        self.alert = alert
        self.firebaseAuthManager = firebaseAuthManager
    }
    
    func toMainScreenIfSuccess() {
        router?.initialViewController()
    }
    
    func registerTap(userName: String, email: String, password: String) {
        firebaseAuthManager?.createUser(userName: userName, email: email, password: password, completionBlock: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            
            }
        })
    }
    
    func inputCheck(userName: String, email: String, password: String, passwordConform: String) throws -> Bool {
        if userName == "" || email == "" || password == "" || passwordConform == "" {
            throw ValidateInputError.emptyString
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let emailResult: Bool = emailPred.evaluate(with: email)
        if !emailResult {
            throw ValidateInputError.wrongSymbolsEmail
        }
        
        let userNameRegEx = "[A-Z0-9a-z._%+-]{2,64}"
        let userNamePred = NSPredicate(format: "SELF MATCHES %@", userNameRegEx)
        let userNameResult: Bool = userNamePred.evaluate(with: userName)
        if !userNameResult {
            throw ValidateInputError.userNameError
        }
        
        let passwordRegEx = "[A-Z0-9a-z._%+-]{2,64}"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let passwordResult: Bool = passwordPred.evaluate(with: password)
        if !passwordResult {
            throw ValidateInputError.passwordIncorrect
        }
        
        let passwordConformRegEx = "[A-Z0-9a-z._%+-]{2,64}"
        let passwordConformPred = NSPredicate(format: "SELF MATCHES %@", passwordConformRegEx)
        let passwordConformResult: Bool = passwordConformPred.evaluate(with: passwordConform)
        if !passwordConformResult {
            throw ValidateInputError.passwordIncorrect
        }
        
        if password != passwordConform {
            throw ValidateInputError.passwordNotMatch
        }
        var result: Bool = false
        
        if emailResult && userNameResult && passwordResult && passwordConformResult {
            if password == passwordConform {
                result = true
            }
        } else {
            result = false
        }
        
        return result
    }
    
}
