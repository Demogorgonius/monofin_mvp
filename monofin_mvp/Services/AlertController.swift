//
//  AlertController.swift
//  monofin_mvp
//
//  Created by Sergey on 08.12.2020.
//

import Foundation
import UIKit



protocol AlertOutputProtocol: class {
    func showAlert(title: String, message: String) -> UIAlertController
}

class AlertController: AlertOutputProtocol {
    
    func showAlert(title: String, message: String) -> UIAlertController {
//        DispatchQueue.main.async(execute: {
//            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
//            alertWindow.rootViewController = UIViewController()
//            alertWindow.windowLevel = UIWindow.Level.alert+10
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            
//            alertWindow.makeKeyAndVisible()
//
//            alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
//        })
        return alert
    }
    
}
