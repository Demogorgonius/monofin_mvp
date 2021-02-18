//
//  LoginEmailPresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 12.12.2020.
//

import Foundation
import UIKit

enum SuccessSelector {
    case forgottenPassword
    case loginOk
}

protocol LoginEmailOutputProtocol: class {
    func success(type: SuccessSelector)
    func failure(error: Error)
}

protocol LoginEmailInputProtocol: class {
    
    init(view: LoginEmailOutputProtocol, router: RouterInputProtocol, alert: AlertInputProtocol, firebaseAuthManager: FireBaseInputProtocol, validator: ValidatorInputProtocol)
    func loginTap(email: String, password: String)
    func rememberPassword(email: String)
    func toMainScreenIfSuccess()
    
}

class LoginEmailPresenter: LoginEmailInputProtocol {
    var userParam: UserInfo!
    weak var view: LoginEmailOutputProtocol?
    var router: RouterInputProtocol?
    var alert: AlertInputProtocol?
    var firebaseAuthManager: FireBaseInputProtocol?
    var validator: ValidatorInputProtocol?
    
    required init(view: LoginEmailOutputProtocol,
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
    
    func rememberPassword(email: String) {
        firebaseAuthManager?.rememberPassword(email: email, complitionBlock:{ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.view?.failure(error: error)
            case .success(_):
                self.view?.success(type: .forgottenPassword)
            }
        })
    }
        
    func loginTap(email: String, password: String) {
        
        firebaseAuthManager?.signIn(email: email, password: password, completionBlock: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                self.userParam = user
                let defaults = UserDefaults.standard
                defaults.set(self.userParam.userName, forKey: "userName")
                defaults.set(self.userParam.email, forKey: "userEmail")
                defaults.set(self.userParam.photoURL, forKey: "userPhotoUrl")
                defaults.set(self.userParam.password, forKey: "password")
                self.view?.success(type: .loginOk)
            case .failure(let error):
                self.view?.failure(error: error)
            }
            
        })
        
    }
    
    func toMainScreenIfSuccess() {
        router?.initialViewController()
    }
    
    
}
