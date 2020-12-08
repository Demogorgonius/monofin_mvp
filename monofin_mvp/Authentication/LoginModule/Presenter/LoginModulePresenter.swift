//
//  LoginModulePresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 08.12.2020.
//

import Foundation

protocol LoginModuleInputProtocol: class {
    init(router: RouterOutputProtocol)
    func loginTapped()
    func registerTapped()
}

class LoginModulePresenter: LoginModuleInputProtocol {
    var router: RouterOutputProtocol?
    required init(router: RouterOutputProtocol) {
        self.router = router
    }
    func loginTapped() {
        router?.showAuthSelectViewController()
    }
    
    func registerTapped() {
        router?.showAuthSelectViewController()
    }
    
    
}
