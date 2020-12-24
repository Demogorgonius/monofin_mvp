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
    
    //MARK: - Variables
    
    var presenter: RegisterEmailInputProtocol!
    var alert: AlertInputProtocol!
    var validator: ValidatorInputProtocol!
    
    //MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterEmailViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterEmailViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        registerButton.layer.cornerRadius = registerButton.layer.bounds.height/2
        
        emailTextField.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.cornerRadius = emailTextField.layer.bounds.height/4
        userNameTextField.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        userNameTextField.layer.borderWidth = 1.0
        userNameTextField.layer.cornerRadius = userNameTextField.layer.bounds.height/4
        passwordTextField.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.cornerRadius = passwordTextField.layer.bounds.height/4
        passwordConformTextField.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        passwordConformTextField.layer.borderWidth = 1.0
        passwordConformTextField.layer.cornerRadius = passwordConformTextField.layer.bounds.height/4
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backgroundImageView.bounds
        view.addSubview(blurredEffectView)
        let subViewCount = view.subviews.count
        view.exchangeSubview(at: 1, withSubviewAt: subViewCount-1)
        
        view.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.alpha = 0.5
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Вернуться", style: .plain, target: nil, action: nil)
    }
    
    
    
    //MARK: - @IBAction
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        var checkResault: Bool = false
        if let userName = userNameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text,
           let pasConform = passwordConformTextField.text {
            checkResault = presenter.inputCheck(userName: userName, email: email, password: password, passwordConform: pasConform)
            checkResault ? presenter.registerTap(userName: userName, email: email, password: password) : nil
        }
        
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

//MARK: - Extension

extension RegisterEmailViewController: RegisterEmailOutputProtocol {
    
    func success() {
        
        presenter.toMainScreenIfSuccess()
    }
    
    func failure(error: Error) {
        present(alert.showAlert(title: "Ошибка регистрации", message: error.localizedDescription), animated: true)
    }
    
    
}
