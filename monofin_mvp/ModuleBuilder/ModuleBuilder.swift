//
//  ModuleBuilder.swift
//  monofin_mvp
//
//  Created by Sergey on 20.11.2020.
//
import UIKit
import Foundation

protocol AssemblyBuilderProtocol {
    
    func createCalendarMainModule(router: RouterOutputProtocol) -> UIViewController
    func createAuthSelectModule(router: RouterOutputProtocol) -> UIViewController
    func createRegisterEmailModule(router: RouterOutputProtocol) -> UIViewController
    func createLoginModule(router: RouterOutputProtocol) -> UIViewController
    
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createCalendarMainModule(router: RouterOutputProtocol) -> UIViewController {
        
        let view = CalendarMainViewController()
        let presenter = CalendarMainPresenter(router: router)
        view.presenter = presenter
        return view
        
    }
    
    func createLoginModule(router: RouterOutputProtocol) -> UIViewController {
        
        let view = LoginViewController()
        let presenter = LoginModulePresenter(router: router)
        view.presenter = presenter
        return view
        
    }
    
    func createAuthSelectModule(router: RouterOutputProtocol) -> UIViewController {
        
        let view = AuthSelectViewController()
        return view
    }
    
    func createRegisterEmailModule(router: RouterOutputProtocol) -> UIViewController {
        let view = RegisterEmailViewController()
        return view
    }
    
}
