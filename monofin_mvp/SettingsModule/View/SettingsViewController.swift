//
//  SettingsViewController.swift
//  monofin_mvp
//
//  Created by Sergey on 13.12.2020.
//

import UIKit


class SettingsViewController: UIViewController {
    //MARK: - @IBOutlet
    
    @IBOutlet weak var userLogoutButton: UIButton!
    @IBOutlet weak var userDeleteButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var backImageView: UIImageView!
    
    //MARK: - Variables
    
    var presenter: SettingsPresenterInputProtocol!
    var alert: AlertInputProtocol!
    var validator: ValidatorInputProtocol!
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backImageView.bounds
        view.addSubview(blurredEffectView)
        let subViewCount = view.subviews.count
        view.exchangeSubview(at: 1, withSubviewAt: subViewCount-1)
        
        userLogoutButton.layer.cornerRadius = userLogoutButton.bounds.height/2
        userDeleteButton.layer.cornerRadius = userDeleteButton.bounds.height/2
        changePasswordButton.layer.cornerRadius = changePasswordButton.bounds.height/2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - @IBActions
    
    @IBAction func logoutTapped(_ sender: Any) {
        present(presenter.logoutTap(), animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        var validateResult: Bool = false
        present(alert.showAlertRegQuestion(title: "Внимание", message: "Подтвердите удаление:", completionBlock: { (result, email, password) in
            
            switch result {
            case true:
                if let emailToVal = email {
                    do {
                        validateResult = try self.validator.checkString(stringType: .email, string: emailToVal)
                    } catch {
                        self.present(self.alert.showAlert(title: "Внимание", message: error.localizedDescription), animated: true)
                    }
                }
                if let passToVal = password {
                    do {
                        validateResult = try self.validator.checkString(stringType: .password, string: passToVal)
                    } catch {
                        self.present(self.alert.showAlert(title: "Внимание!", message: error.localizedDescription), animated: true)
                    }
                }
                if validateResult == true {
                    self.presenter.checkCurentUser(email: email!, passowrd: password!)
                }
            case false:
                validateResult = false
            }
            
        }), animated: true)
        
    }
    
    //MARK: - Functions
    
    
}

//MARK: - Extension

extension SettingsViewController: SettingsPresenterOutputProtocol {
    func success(type: TypeOfAction) {
        switch type {
        case .checkCurentUser:
            presenter.deleteTap()
        case .chengePassword:
            print("")
        }
    }
    func failure(error: Error) {
        present(alert.showAlert(title: "Внимание", message: error.localizedDescription), animated: true)
    }
  
}
