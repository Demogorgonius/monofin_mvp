//
//  LoginEmailPresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 12.12.2020.
//

import Foundation
import UIKit

protocol LoginEmailOutputProtocol: class {
    func success()
    func failure(error: Error)
}

protocol LoginEmailInputProtocol: class {
    
    init(view: LoginEmailOutputProtocol, router: RouterInputProtocol, alert: AlertInputProtocol, firebaseAuthManager: FireBaseInputProtocol)
    func validateInputParam(email: String, password: String) throws -> Bool
    func loginTap(email: String, password: String)
    func toMainScreenIfSuccess()
    
}

class LoginEmailPresenter: LoginEmailInputProtocol {
    
    var view: LoginEmailOutputProtocol?
    var router: RouterInputProtocol?
    var alert: AlertInputProtocol?
    var firebaseAuthManager: FireBaseInputProtocol?
    
    required init(view: LoginEmailOutputProtocol, router: RouterInputProtocol, alert: AlertInputProtocol, firebaseAuthManager: FireBaseInputProtocol) {
        self.view = view
        self.router = router
        self.alert = alert
        self.firebaseAuthManager = firebaseAuthManager
    }
    
    func validateInputParam(email: String, password: String) throws -> Bool {
        
        if email == "" || password == "" {
            throw ValidateInputError.emptyString
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let emailResult: Bool = emailPred.evaluate(with: email)
        if !emailResult {
            throw ValidateInputError.wrongSymbolsEmail
        }
        let passwordRegEx = "[A-Z0-9a-z._%+-]{2,64}"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        let passwordResult: Bool = passwordPred.evaluate(with: password)
        if !passwordResult {
            throw ValidateInputError.passwordIncorrect
        }
        var result: Bool = false
        
        if emailResult && passwordResult {
            result = true
        } else {
            result = false
        }
        
        return result
    }
    
    func loginTap(email: String, password: String) {
        
        firebaseAuthManager?.signIn(email: email, password: password, completionBlock: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            }
            
        })
        
    }
    
    func toMainScreenIfSuccess() {
        router?.initialViewController()
    }
    
    
}
