//
//  SettingsPresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 13.12.2020.
//

import Foundation
import UIKit

enum TypeOfAction {
    case checkCurentUser
    case changePassword
    case gettingAvatar
}

protocol SettingsPresenterOutputProtocol: class {
    
    func success(type: TypeOfAction, avatarImage: UIImage?)
    func failure(error: Error)
    
}

protocol SettingsPresenterInputProtocol: class {
    
    init(view: SettingsPresenterOutputProtocol,
         router: RouterInputProtocol,
         alert: AlertInputProtocol,
         firebaseAuthManager: FireBaseInputProtocol,
         validator: ValidatorInputProtocol,
         fireStoreManager: FireStoreProtocol)
    func logoutTap() -> UIAlertController
    func deleteTap()
    func checkCurentUser(email: String, passowrd: String)
    func changePassword(newPassword: String)
    func passwordMatch(passwordOne: String, passwordTwo: String)
    func saveAvatar(image: UIImage)
    func getAvatar()
    
    
}

class SettingsPresenterProtocol: SettingsPresenterInputProtocol {
    
    weak var view: SettingsPresenterOutputProtocol?
    var router: RouterInputProtocol?
    var alert: AlertInputProtocol?
    var firebaseAuthManager: FireBaseInputProtocol?
    var validator: ValidatorInputProtocol?
    var fireStoreManager: FireStoreProtocol?
    
    
    required init(view: SettingsPresenterOutputProtocol,
                  router: RouterInputProtocol,
                  alert: AlertInputProtocol,
                  firebaseAuthManager: FireBaseInputProtocol,
                  validator: ValidatorInputProtocol,
                  fireStoreManager: FireStoreProtocol) {
        
        self.view = view
        self.router = router
        self.alert = alert
        self.firebaseAuthManager = firebaseAuthManager
        self.validator = validator
        self.fireStoreManager = fireStoreManager
        
    }
    
    func logoutTap() -> UIAlertController {
        return (alert?.showAlertQuestion(title: "Внимание!", message: "Вы действительно хотите выйти?", completionBlock: { resault in
            
            switch resault {
            case true:
                print("user select OK !!!")
                UserDefaults.standard.set(nil, forKey: "uid")
                UserDefaults.standard.set(nil, forKey: "userName")
                UserDefaults.standard.set(nil, forKey: "userEmail")
                UserDefaults.standard.set(nil, forKey: "userPhotoUrl")
                self.router?.loginViewController()
            case false:
                print("user select cancel  !!!")
            }
        }))!
        
    }
    
    func checkCurentUser(email: String, passowrd: String) {
        let uid: String = UserDefaults.standard.value(forKey: "uid") as! String
        firebaseAuthManager?.checkCurentUser(email: email, password: passowrd, uid: uid, completionBlock: { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.view?.failure(error: error)
            case .success(let authCheck):
                if authCheck {
                    self.view?.success(type: .checkCurentUser, avatarImage: nil)
                } else {
                    self.view?.failure(error: ValidateInputError.authError)                    
                }
            }
            
        })
        
    }
    
    func deleteTap() {
        
        firebaseAuthManager?.deleteUser(completionBlock: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                UserDefaults.standard.setValue(nil, forKey: "uid")
                UserDefaults.standard.set(nil, forKey: "userName")
                UserDefaults.standard.set(nil, forKey: "userEmail")
                UserDefaults.standard.set(nil, forKey: "userPhotoUrl")
                self.router?.loginViewController()
            case .failure(let error):
                self.view?.failure(error: error)
            }
            
        })
    }
    
    func changePassword(newPassword: String) {
        firebaseAuthManager?.changePassword(newPassword: newPassword, completionBlock: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.view?.failure(error: error)
            case .success(_):
                self.view?.success(type: .changePassword, avatarImage: nil)
            }
            
        })
    }
    
    func passwordMatch(passwordOne: String, passwordTwo: String) {
        
        
        if passwordOne == passwordTwo {
            changePassword(newPassword: passwordOne)
        } else {
            view?.failure(error: ValidateInputError.passwordNotMatch)
        }
        
    }
    
    func saveAvatar(image: UIImage) {
        let defaults = UserDefaults.standard
        if defaults.value(forKey: "userPhotoUrl") == nil {
            if defaults.value(forKey: "uid") != nil {
                let uid = defaults.string(forKey: "uid")
                fireStoreManager?.saveAvatar(photo: image, uid: uid!, completion: { result in
                    switch result {
                    case .failure(let error):
                        self.view?.failure(error: error)
                    case .success(let url):
                        defaults.set(url.absoluteString, forKey: "userPhotoUrl")
                    }
                })
                
            } else {
                return
            }
        } else {
            let url = defaults.string(forKey: "userPhotoUrl")
            fireStoreManager?.deleteAvatar(url: url!, completion: { result in
                switch result {
                case .failure(let error):
                    self.view?.failure(error: error)
                case .success(_):
                    print("Old avatar has been delete!")
                }
            })
            
            let uid = defaults.string(forKey: "uid")
            fireStoreManager?.saveAvatar(photo: image, uid: uid!, completion: { result in
                switch result {
                case .failure(let error):
                    self.view?.failure(error: error)
                case .success(let url):
                    defaults.set(url.absoluteString, forKey: "userPhotoUrl")
                }
            })
            
        }
    }
    
    func getAvatar() {
        
        let defaults = UserDefaults.standard
        if let userAvatarUrl = defaults.string(forKey: "userPhotoUrl") {
            fireStoreManager?.getAvatar(url: userAvatarUrl, completion: { result in
                switch result {
                case .failure(let error):
                    self.view?.failure(error: error)
                case .success(let avatar):
                    self.view?.success(type: .gettingAvatar, avatarImage: avatar)
                }
            })
        } else {
            return
        }
        
        
    }
    
}
