//
//  RegisterEmailPresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 08.12.2020.
//

import Foundation
import UIKit



protocol RegisterEmailOutputProtocol: class {
    func success()
    func failure(error: Error)
}

protocol RegisterEmailInputProtocol: class {
    init(view: RegisterEmailOutputProtocol, router: RouterInputProtocol, alert: AlertInputProtocol, firebaseAuthManager: FireBaseInputProtocol, validator: ValidatorInputProtocol)
    func registerTap(userName: String, email: String, password: String)
    func inputCheck(userName: String, email: String, password: String, passwordConform: String) -> Bool
    func toMainScreenIfSuccess()
    var userInfo: UserInfo? { get set }
}

class RegisterEmailPresenter: RegisterEmailInputProtocol {
    
    weak var view: RegisterEmailOutputProtocol?
    var router: RouterInputProtocol?
    var alert: AlertInputProtocol?
    var firebaseAuthManager: FireBaseInputProtocol?
    var validator: ValidatorInputProtocol?
    var userInfo: UserInfo?
    
    
    required init(view: RegisterEmailOutputProtocol,
                  router: RouterInputProtocol,
                  alert: AlertInputProtocol,
                  firebaseAuthManager: FireBaseInputProtocol,
                  validator: ValidatorInputProtocol) {
        self.view = view
        self.router = router
        self.alert = alert
        self.firebaseAuthManager = firebaseAuthManager
        self.validator = validator
    }
    
    func toMainScreenIfSuccess() {
        router?.initialViewController(user: userInfo)
    }
    
    func registerTap(userName: String, email: String, password: String) {
        firebaseAuthManager?.createUser(userName: userName, email: email, password: password, completionBlock: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.userInfo = user
                self.view?.success()
            case .failure(let error):
                self.view?.failure(error: error)
            
            }
        })
    }
    
    func inputCheck(userName: String, email: String, password: String, passwordConform: String) -> Bool {
        var result: Bool = false
        if userName == "" || email == "" || password == "" || passwordConform == "" {
            view?.failure(error: ValidateInputError.emptyString)
        }
        do {
            result = ((try validator?.checkString(stringType: .email, string: email)) != nil)
            result = ((try validator?.checkString(stringType: .userName, string: userName)) != nil)
            result = ((try validator?.checkString(stringType: .password, string: password)) != nil)
            result = ((try validator?.checkString(stringType: .password, string: passwordConform)) != nil)
        } catch {
            view?.failure(error: error)
        }
        if password == passwordConform {
            result = true
        } else {
            result = false
            view?.failure(error: ValidateInputError.passwordNotMatch)
        }
       
        return result
    }
    
}
