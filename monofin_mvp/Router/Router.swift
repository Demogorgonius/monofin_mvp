//
//  Router.swift
//  monofin_mvp
//
//  Created by Sergey on 20.11.2020.
//

import Foundation
import UIKit

protocol RouterInputProtocol: class {
    var navigationVC: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterOutputProtocol: RouterInputProtocol {
    func initialViewController()
    func authSelectViewController()
}

class Router: RouterOutputProtocol {
    
    var navigationVC: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationVC: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol){
        self.navigationVC = navigationVC
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationVC = navigationVC {
            guard let calendarMainModule = assemblyBuilder?.createCalendarMainModule(router: self) else { return }
            navigationVC.viewControllers = [calendarMainModule]
        }
    }
    
    func authSelectViewController() {
        if let navigationVC = navigationVC {
            guard let authSelectVC = assemblyBuilder?.createAuthSelectModule(router: self) else { return }
            navigationVC.viewControllers = [authSelectVC]
        }
    }
    
}
