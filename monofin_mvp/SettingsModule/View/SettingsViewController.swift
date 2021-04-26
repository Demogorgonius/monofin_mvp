//
//  SettingsViewController.swift
//  monofin_mvp
//
//  Created by Sergey on 13.12.2020.
//

import UIKit


class SettingsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    //MARK: - @IBOutlet
    
    @IBOutlet weak var userLogoutButton: UIButton!
    @IBOutlet weak var userDeleteButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var changeAvatarButton: UIButton!
    @IBOutlet weak var userNameLabel : UILabel!
    
    //MARK: - Variables
    
    var presenter: SettingsPresenterInputProtocol!
    var alert: AlertInputProtocol!
    var validator: ValidatorInputProtocol!
    var fireStoreManager: FireStoreProtocol!
    var imagePicker = UIImagePickerController()
    
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
        changeAvatarButton.layer.cornerRadius = changeAvatarButton.bounds.height/2
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height/2
        presenter.getAvatar()
        presenter.getUserName()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - @IBActions
    
    @IBAction func avatarChangeTapped(_ sender: Any) {
        
        let alertImage = UIAlertController(title: "Источник фотографии", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Камера", style: .default) { action in
          self.chooseImagePickerAction(source: .camera)
        }
        let photoAction = UIAlertAction(title: "Фото", style: .default) { action in
            self.chooseImagePickerAction(source: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alertImage.addAction(cameraAction)
        alertImage.addAction(photoAction)
        alertImage.addAction(cancelAction)
        
        present(alertImage, animated: true)
        
    }
    
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
    
    @IBAction func passwordChangeTapped(_ sender: Any) {
        
        var validationResult: Bool = false
        present( alert.showAlertPassValidation(title: "Внимание", message: "Введите новый пароль:", completionBlock: { (result, passwordOne, passwordTwo) in
            switch result {
            case true:
                if let password = passwordOne {
                    do {
                        validationResult = try self.validator.checkString(stringType: .password, string: password)
                    } catch {
                        self.present(self.alert.showAlert(title: "Внимание", message: error.localizedDescription), animated: true)
                    }
                }
                if let password = passwordTwo {
                    do {
                        validationResult = try self.validator.checkString(stringType: .password, string: password)
                    } catch {
                        self.present(self.alert.showAlert(title: "Внимание!", message: error.localizedDescription), animated: true)
                    }
                }
                if validationResult == true {
                    if let password = passwordOne {
                        if let passwordConform = passwordTwo { self.presenter.passwordMatch(passwordOne: password, passwordTwo: passwordConform) }
                    }
                }
            case false:
                validationResult = false
            }
        }) , animated: true)
    }
    
    //MARK: - Functions
    func chooseImagePickerAction(source: UIImagePickerController.SourceType) {

        if UIImagePickerController.isSourceTypeAvailable(source) {
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source

            self.present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        avatarImageView.image = info[.editedImage] as? UIImage
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
        presenter.saveAvatar(image: avatarImageView.image!)
    }
    
    
}

//MARK: - Extension


extension SettingsViewController: SettingsPresenterOutputProtocol {
    func success(type: TypeOfAction, avatarImage: UIImage?, userName: String?) {
        switch type {
        case .checkCurentUser:
            presenter.deleteTap()
        case .changePassword:
            present(alert.showAlert(title: "Внимание!", message: "Пароль был изменён!"), animated: true)
        case .gettingAvatar:
            if let avatarImage = avatarImage {
                avatarImageView.image = avatarImage
                
            } else {
                print("Can't present avatar image!!!")
                return
            }
        case .gettingUserName:
            if let userName = userName {
                userNameLabel.text = userName
            } else {
                print("Can`t set user name!!!")
                return
            }
        }
    }
    func failure(error: Error) {
        present(alert.showAlert(title: "Ошибка!", message: error.localizedDescription), animated: true)
    }
  
}

