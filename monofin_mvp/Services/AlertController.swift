//
//  AlertController.swift
//  monofin_mvp
//
//  Created by Sergey on 08.12.2020.
//

import Foundation
import UIKit



protocol AlertInputProtocol: class {
    func showAlert(title: String, message: String) -> UIAlertController
    func showAlertQuestion(title: String, message: String, completionBlock: @escaping(Bool) -> Void) -> UIAlertController
}

class AlertController: AlertInputProtocol {
    
    func showAlert(title: String, message: String) -> UIAlertController {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            return alert
        
    }
    func showAlertQuestion(title: String, message: String, completionBlock complitionBlock: @escaping(Bool) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Да", style: .default) { action in
            complitionBlock(true)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { action in
            complitionBlock(false)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        return alert
    }
    
}
