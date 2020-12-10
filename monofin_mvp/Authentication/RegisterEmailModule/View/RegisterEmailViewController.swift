//
//  AuthEmailViewController.swift
//  monofin_mvp
//
//  Created by Sergey on 08.12.2020.
//

import UIKit

class RegisterEmailViewController: UIViewController {
    
    //MARK: - @IBOutlet
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConformTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var presenter: RegisterEmailOutputProtocol!
    var alert: AlertOutputProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.cornerRadius = registerButton.layer.bounds.height/2
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backgroundImageView.bounds
        view.addSubview(blurredEffectView)
        let subViewCount = view.subviews.count
        view.exchangeSubview(at: 1, withSubviewAt: subViewCount-1)
        
    }
    
    //MARK: - @IBAction
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        let userName = userNameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let pasConform = passwordConformTextField.text!
        do {
            let checkReasult = try presenter.inputCheck(userName: userName, email: email, password: password, passwordConform: pasConform)
        } catch ValidateInputError.emptyString {
            
            present(alert.showAlert(title: "Ошибка", message: "Все поля должны быть заполнены!"), animated: true)
            
        } catch ValidateInputError.userNameError {
            
            present(alert.showAlert(title: "Ошибка", message: "Некоректное имя пользователя!"), animated: true)
        } catch ValidateInputError.wrongSymbolsEmail {
            
            present(alert.showAlert(title: "Ошибка", message: "Некоректный e-mail адрес!"), animated: true)
        
        } catch ValidateInputError.passwordIncorrect {
            
            present(alert.showAlert(title: "Ошибка", message: "Некоректный пароль!"), animated: true)
            
        } catch ValidateInputError.passwordNotMatch {
            
            present(alert.showAlert(title: "Ошибка", message: "Пароли не совпадают!"), animated: true)
            
        } catch {
            
            present(alert.showAlert(title: "Ошибка", message: "Что-то пошло не так! =)"), animated: true)
            
        }
        
    }
    
}

extension RegisterEmailViewController: RegisterEmailInputProtocol {
    func showAlert(title: String, message: String) {
        
    }
    
    func success() {
        
    }
    
    func failure(error: Error) {
        
    }
    
    
}
