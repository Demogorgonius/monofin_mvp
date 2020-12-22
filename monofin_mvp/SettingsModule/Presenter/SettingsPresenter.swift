//
//  SettingsPresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 13.12.2020.
//

import Foundation
import UIKit

enum TypeOfAction {
    case checkCurentUser
    case chengePassword
}

protocol SettingsPresenterOutputProtocol: class {
    
    func success(type: TypeOfAction)
    func failure(error: Error)
    
}

protocol SettingsPresenterInputProtocol: class {
    
    init(view: SettingsPresenterOutputProtocol,
         router: RouterInputProtocol,
         alert: AlertInputProtocol,
         firebaseAuthManager: FireBaseInputProtocol,
         validator: ValidatorInputProtocol)
    func logoutTap() -> UIAlertController
    func deleteTap()
    func checkCurentUser(email: String, passowrd: String)
    
}

class SettingsPresenterProtocol: SettingsPresenterInputProtocol {
    
    var view: SettingsPresenterOutputProtocol?
    var router: RouterInputProtocol?
    var alert: AlertInputProtocol?
    var firebaseAuthManager: FireBaseInputProtocol?
    var validator: ValidatorInputProtocol?
    
    required init(view: SettingsPresenterOutputProtocol,
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
    
    func logoutTap() -> UIAlertController {
        return (alert?.showAlertQuestion(title: "Внимание!", message: "Вы действительно хотите выйти?", completionBlock: { resault in
            
            switch resault {
            case true:
                print("user select OK !!!")
                UserDefaults.standard.set(nil, forKey: "uid")
                self.router?.loginViewController()
            case false:
                print("user select cancel  !!!")
            }
        }))!
        
    }
    
    func checkCurentUser(email: String, passowrd: String) {
        let uid: String = UserDefaults.standard.value(forKey: "uid") as! String
        firebaseAuthManager?.checkCurenUser(email: email, password: passowrd, uid: uid, completionBlock: { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.view?.failure(error: error)
            case .success(let authCheck):
                if authCheck {
                    self.view?.success(type: .checkCurentUser)
                } else {
                    self.view?.failure(error: ValidateInputError.authError)                    
                }
            }
            
        })
        
    }
    
    func deleteTap() {
        
        firebaseAuthManager?.deleteUser(completionBlock: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                UserDefaults.standard.setValue(nil, forKey: "uid")
                self.router?.loginViewController()
            case .failure(let error):
                self.view?.failure(error: error)
            }
            
        })
    }
    
    
}
