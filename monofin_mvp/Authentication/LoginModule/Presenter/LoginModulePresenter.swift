//
//  LoginModulePresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 08.12.2020.
//

import Foundation

protocol LoginModuleInputProtocol: class {
    init(router: RouterInputProtocol)
    func loginTapped()
    func registerTapped()
}

class LoginModulePresenter: LoginModuleInputProtocol {
    var router: RouterInputProtocol?
    required init(router: RouterInputProtocol) {
        self.router = router
    }
    func loginTapped() {
        router?.showLoginSelectViewController()
    }
    
    func registerTapped() {
        router?.showAuthSelectViewController()
    }
    
    
}
