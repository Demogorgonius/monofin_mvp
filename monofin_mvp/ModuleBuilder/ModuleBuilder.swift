//
//  ModuleBuilder.swift
//  monofin_mvp
//
//  Created by Sergey on 20.11.2020.
//
import UIKit
import Foundation

protocol AssemblyBuilderProtocol: class {
    func createCalendarMainModule(router: RouterInputProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createCalendarMainModule(router: RouterInputProtocol) -> UIViewController {
        let view = CalendarMainViewController()
        return view
    }
}
