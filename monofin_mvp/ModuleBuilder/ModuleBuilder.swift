//
//  ModuleBuilder.swift
//  monofin_mvp
//
//  Created by Sergey on 20.11.2020.
//
import UIKit
import Foundation

protocol AssemblyBuilderProtocol {
    
    func createCalendarMainModule(user: UserInfo?, router: RouterInputProtocol, fireBaseAuth: FireBaseInputProtocol) -> UIViewController
    func createAuthSelectModule(router: RouterInputProtocol) -> UIViewController
    func createRegisterEmailModule(router: RouterInputProtocol) -> UIViewController
    func createLoginModule(router: RouterInputProtocol) -> UIViewController
    func createLoginSelectModule(router: RouterInputProtocol) -> UIViewController
    func createLoginEmailModule(router: RouterInputProtocol) -> UIViewController
    func createSettingsModule(user: UserInfo?, router: RouterInputProtocol) -> UIViewController
    
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    
    
    func createCalendarMainModule(user: UserInfo?, router: RouterInputProtocol, fireBaseAuth: FireBaseInputProtocol) -> UIViewController {
        
        let view = CalendarMainViewController()
        let presenter = CalendarMainPresenter(view: view, router: router, fireBaseAuth: fireBaseAuth)
        view.presenter = presenter
        return view
        
    }
    
    func createLoginModule(router: RouterInputProtocol) -> UIViewController {
        
        let view = LoginViewController()
        let presenter = LoginModulePresenter(router: router)
        view.presenter = presenter
        return view
        
    }
    
    func createAuthSelectModule(router: RouterInputProtocol) -> UIViewController {
        
        let view = AuthSelectViewController()
        let presenter = AuthSelectPresenter(router: router)
        let alert =  AlertController()
        view.presenter = presenter
        view.alert = alert
        return view
        
    }
    
    func createRegisterEmailModule(router: RouterInputProtocol) -> UIViewController {
        
        let firebaseAuthManager = FireBaseAuthManager()
        let view = RegisterEmailViewController()
        let alert = AlertController()
        let validator = ValidatiorClass()
        let presenter = RegisterEmailPresenter(view: view, router: router, alert: alert, firebaseAuthManager: firebaseAuthManager, validator: validator)
        view.validator = validator
        view.presenter = presenter
        view.alert = alert
        return view
        
    }
    
    func createLoginSelectModule(router: RouterInputProtocol) -> UIViewController {
        
        let view = LoginSelectViewController()
        let presenter = LoginSelectPresenter(router: router)
        view.presenter = presenter
        return view
        
    }
    
    func createLoginEmailModule(router: RouterInputProtocol) -> UIViewController {
        
        let firebaseAuthManager = FireBaseAuthManager()
        let validator = ValidatiorClass()
        let view = LoginEmailViewController()
        let alert = AlertController()
        let presenter = LoginEmailPresenter(view: view, router: router, alert: alert, firebaseAuthManager: firebaseAuthManager, validator: validator)
        view.validator = validator
        view.presenter = presenter
        view.alert = alert
        return view
        
    }
    
    func createSettingsModule(user: UserInfo?, router: RouterInputProtocol) -> UIViewController {
        let firebaseAuthManager = FireBaseAuthManager()
        let view = SettingsViewController()
        let alert = AlertController()
        let validator = ValidatiorClass()
        let presenter = SettingsPresenterProtocol(view: view, router: router, alert: alert, firebaseAuthManager: firebaseAuthManager, validator: validator, user: user)
        view.validator = validator
        view.presenter = presenter
        view.alert = alert
        return view
    }
}
