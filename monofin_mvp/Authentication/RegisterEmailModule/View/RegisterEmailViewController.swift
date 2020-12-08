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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerButton.layer.cornerRadius = registerButton.layer.bounds.height/2
        
        // Do any additional setup after loading the view.
    }

    //MARK: - @IBAction
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
    }
    
}
