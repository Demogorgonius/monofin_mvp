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
    func showAlertRegQuestion(title: String, message: String, completionBlock: @escaping(_ action: Bool, _ emailInput: String?, _ pasInput: String?) -> Void) -> UIAlertController
    func showAlertPassValidation(title: String, message: String, completionBlock: @escaping(_ action: Bool, _ pass: String?, _ newPass: String?) -> Void) -> UIAlertController
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
    
    func showAlertRegQuestion(title: String, message: String, completionBlock: @escaping (Bool, String?, String?) -> Void) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.textContentType = .emailAddress
            textField.placeholder = "E-Mail"
        }
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Пароль"
            textField.textContentType = .password
            textField.isSecureTextEntry = true
        }
        let okAction = UIAlertAction(title: "Удалить", style: .default) { action in
            let emailTextField = alert.textFields![0] as UITextField
            let passwordTextField = alert.textFields![1] as UITextField
            completionBlock(true, emailTextField.text, passwordTextField.text)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (action) in
            completionBlock(false, "", "")
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        return alert
        
    }
    
    func showAlertPassValidation(title: String, message: String, completionBlock: @escaping (Bool, String?, String?) -> Void) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) in
            textField.textContentType = .password
            textField.placeholder = "Новый пароль"
            textField.isSecureTextEntry = true
        }
        alert.addTextField { (textField: UITextField) in
            textField.textContentType = .newPassword
            textField.isSecureTextEntry = true
            textField.placeholder = "Пароль ещё раз"
        }
        
        let okAction = UIAlertAction(title: "Сменить", style: .default) { action in
            let oldPassword = alert.textFields![0].text
            let newPassword = alert.textFields![1].text
            completionBlock(true, oldPassword, newPassword)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { action in
            completionBlock(false, "", "")
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        return alert
        
    }
    
}
