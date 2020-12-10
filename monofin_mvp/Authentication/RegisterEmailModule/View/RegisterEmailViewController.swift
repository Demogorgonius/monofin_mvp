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
        
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterEmailViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterEmailViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        registerButton.layer.cornerRadius = registerButton.layer.bounds.height/2
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backgroundImageView.bounds
        view.addSubview(blurredEffectView)
        let subViewCount = view.subviews.count
        view.exchangeSubview(at: 1, withSubviewAt: subViewCount-1)
        
        view.addGestureRecognizer(tap)
        
    }
    
    //MARK: - @IBAction
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        if let userName = userNameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text,
           let pasConform = passwordConformTextField.text {
            do {
                let checkReasult = try presenter.inputCheck(userName: userName, email: email, password: password, passwordConform: pasConform)
            } catch {
                
                present(alert.showAlert(title: "Ошибка", message: error.localizedDescription), animated: true)
                
            }
            
        }
        
    }
    
    //MARK: - Func
    
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

extension RegisterEmailViewController: RegisterEmailInputProtocol {
    
    func success() {
        
    }
    
    func failure(error: Error) {
        
    }
    
    
}
