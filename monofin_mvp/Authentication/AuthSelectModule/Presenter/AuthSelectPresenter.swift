//
//  AuthSelectPresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 01.12.2020.
//

import Foundation

protocol AuthSelectProtocol: class {
    init(router: RouterInputProtocol)
    func emailAuthTaped()
    func facebookAuthTapped()
    func phoneAuthTapped()
}

class AuthSelectPresenter: AuthSelectProtocol {
    var router: RouterInputProtocol?
    required init(router: RouterInputProtocol) {
        self.router = router
    }
    
    func emailAuthTaped() {
        router?.showRegisterEmailViewController()
    }
    
    func facebookAuthTapped() {
        
    }
    
    func phoneAuthTapped() {
        
    }
    
    
}
