//
//  SettingsPresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 13.12.2020.
//

import Foundation
import UIKit

protocol SettingsPresenterOutputProtocol: class {
    
    func success()
    func failure(error: Error)
    
}

protocol SettingsPresenterInputProtocol: class {
    init(view: SettingsPresenterOutputProtocol, router: RouterInputProtocol, alert: AlertInputProtocol, firebaseAuthManager: FireBaseInputProtocol)
    func logoutTap() -> UIAlertController
    
}

class SettingsPresenterProtocol: SettingsPresenterInputProtocol {
 
    var view: SettingsPresenterOutputProtocol?
    var router: RouterInputProtocol?
    var alert: AlertInputProtocol?
    var firebaseAuthManager: FireBaseInputProtocol?
    
    required init(view: SettingsPresenterOutputProtocol, router: RouterInputProtocol, alert: AlertInputProtocol, firebaseAuthManager: FireBaseInputProtocol) {
        
        self.view = view
        self.router = router
        self.alert = alert
        self.firebaseAuthManager = firebaseAuthManager
        
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
    
    
}
