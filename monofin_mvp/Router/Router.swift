//
//  Router.swift
//  monofin_mvp
//
//  Created by Sergey on 20.11.2020.
//

import Foundation
import UIKit

protocol RouterOutputProtocol: class {
    var navigationVC: UINavigationController? { get set }
    var tabbarVC: UITabBarController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterInputProtocol: RouterOutputProtocol {
    func initialViewController()
    func showAuthSelectViewController()
    func loginViewController()
    func showRegisterEmailViewController()
    func showLoginSelectViewController()
    func showLoginEmailViewController()
    func showSettingsViewController(user: UserInfo?)
}

class Router: RouterInputProtocol {
    
    var navigationVC: UINavigationController?
    var tabbarVC: UITabBarController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationVC: UINavigationController, tabbarVC: UITabBarController, assemblyBuilder: AssemblyBuilderProtocol){
        self.navigationVC = navigationVC
        self.tabbarVC = tabbarVC
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        
        if let navigationVC = navigationVC {
            if let tabbarVC = tabbarVC {
                guard let calendarVC = assemblyBuilder?.createCalendarMainModule( router: self) else { return }
                guard let settingsVC = assemblyBuilder?.createSettingsModule( router: self) else { return }
                calendarVC.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "home_i"), selectedImage: UIImage(named: "home_a"))
                settingsVC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "set_i"), selectedImage: UIImage(named: "set_a"))
                tabbarVC.viewControllers = [calendarVC, settingsVC]
                navigationVC.viewControllers = [tabbarVC]
            }
            
        }
        
    }
    
    func loginViewController() {
        if let navigationVC = navigationVC {
            guard let loginVC = assemblyBuilder?.createLoginModule(router: self) else { return }
            navigationVC.viewControllers = [loginVC]
        }
    }
    
    func showAuthSelectViewController() {
        if let navigationVC = navigationVC {
            guard let authSelectVC = assemblyBuilder?.createAuthSelectModule(router: self) else { return }
            navigationVC.pushViewController(authSelectVC, animated: true)
        }
    }
    
    func showRegisterEmailViewController() {
        if let navigationVC = navigationVC {
            guard let registerEmailVC = assemblyBuilder?.createRegisterEmailModule(router: self) else { return }
            navigationVC.pushViewController(registerEmailVC, animated: true)
        }
    }
    
    func showLoginSelectViewController() {
        if let navigationVC = navigationVC {
            guard let loginSelectVC = assemblyBuilder?.createLoginSelectModule(router: self) else { return }
            navigationVC.pushViewController(loginSelectVC, animated: true)
        }
    }
    
    func showLoginEmailViewController() {
        if let navigationVC = navigationVC {
            guard let loginEmailVC = assemblyBuilder?.createLoginEmailModule(router: self) else { return }
            navigationVC.pushViewController(loginEmailVC, animated: true)
        }
    }
    
    func showSettingsViewController(user: UserInfo?) {
        if let navigationVC = navigationVC {
            guard let settingsVC = assemblyBuilder?.createSettingsModule(router: self) else { return}
            navigationVC.pushViewController(settingsVC, animated: true)
        }
    }
    
}
