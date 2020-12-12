//
//  LoginSelectPresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 12.12.2020.
//

import Foundation

protocol LoginSelectPresenterProtocol: class {
    
    init(router: RouterInputProtocol)
    func phoneLoginButtonTap()
    func facebookLoginButtonTap()
    func emailLoginButtonTap()
    
}

class LoginSelectPresenter: LoginSelectPresenterProtocol {
    
    var router: RouterInputProtocol?
    required init(router: RouterInputProtocol) {
        self.router = router
    }
    
    func phoneLoginButtonTap() {
        
    }
    
    func facebookLoginButtonTap() {
        
    }
    
    func emailLoginButtonTap() {
        router?.showLoginEmailViewController()
    }
    
   
}
