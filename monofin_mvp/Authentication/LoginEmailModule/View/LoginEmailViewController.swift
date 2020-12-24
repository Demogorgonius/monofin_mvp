//
//  LoginEmailViewController.swift
//  monofin_mvp
//
//  Created by Sergey on 12.12.2020.
//

import UIKit

class LoginEmailViewController: UIViewController {
    
    //MARK: - @IBOutlet
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgottenPasswordButton: UIButton!
    @IBOutlet weak var backImageView: UIImageView!
    
    //MARK: - Variables
    
    var presenter: LoginEmailInputProtocol!
    var alert: AlertInputProtocol!
    var validator: ValidatorInputProtocol!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Actions with view if keyboar show and hide
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginEmailViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginEmailViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //change button style
        
        loginButton.layer.cornerRadius = loginButton.layer.bounds.height/2
        
        emailTextField.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.cornerRadius = emailTextField.layer.bounds.height/4
        passwordTextField.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        passwordTextField.layer.cornerRadius = passwordTextField.layer.bounds.height/4
        passwordTextField.layer.borderWidth = 1.0
        
        //change background style
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backImageView.bounds
        view.addSubview(blurredEffectView)
        let subViewCount = view.subviews.count
        view.exchangeSubview(at: 1, withSubviewAt: subViewCount-1)
        
        view.addGestureRecognizer(tap)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Вернуться", style: .plain, target: nil, action: nil)
        
    }
    
    //MARK: - @IBActions
    
    @IBAction func loginButtonTap(_ sender: Any) {
        var checkResault: Bool?
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            do {
                checkResault = try validator.checkString(stringType: .email, string: email)
                checkResault = try validator.checkString(stringType: .password, string: password)
            } catch {
                present(alert.showAlert(title: "Ошибка", message: error.localizedDescription), animated: true)
            }
            if checkResault == true {
                presenter.loginTap(email: email, password: password)
            }
            
        }
    }
    
    @IBAction func forgottenPasswordTapped(_ sender: Any) {
        var validateResult: Bool = false
        present(alert.showAlertEmailInput(title: "Внимание", message: "Введите e-mail для отправки ссылки на восстановление пароля:") { (result, email) in
            switch result {
            case true:
                if let email = email {
                    do {
                        validateResult = try self.validator.checkString(stringType: .email, string: email)
                    } catch {
                        self.present(self.alert.showAlert(title: "Ошибка!", message: error.localizedDescription), animated: true)
                    }
                }
                if validateResult == true {
                    self.presenter.rememberPassword(email: email!)
                }
            case false:
                validateResult = false
            }
        }, animated: true)
    }
    
    //MARK: - Functions
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        // move the root view up by the distance of keyboard height
        self.view.frame.origin.y = 0 - keyboardSize.height/2
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}

//MARK: - Extensions

extension LoginEmailViewController: LoginEmailOutputProtocol {
    func success(type: SuccessSelector ) {
        switch type {
        case .loginOk:
            presenter.toMainScreenIfSuccess()
        case .forgottenPassword:
            present(alert.showAlert(title: "Внимание!", message: "Вам было отправленно письмо с ссылкой для восстановления пароля."), animated: true)
        }
    }
    
    func failure(error: Error) {
        present(alert.showAlert(title: "Ошибка", message: error.localizedDescription), animated: true)
    }
    
    
}
