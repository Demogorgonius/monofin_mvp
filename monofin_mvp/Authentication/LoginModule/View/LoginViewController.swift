//
//  LoginViewController.swift
//  monofin_mvp
//
//  Created by Sergey on 08.12.2020.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - @IBOutlet
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    //MARK: - @IBAction
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        presenter.loginTapped()
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        presenter.registerTapped()
    }
    
    //MARK: - Variables
    var presenter: LoginModuleInputProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = loginButton.layer.bounds.height/2
        registerButton.layer.cornerRadius = registerButton.layer.bounds.height/2
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = imageView.bounds
        view.addSubview(blurredEffectView)
        let subViewCount = view.subviews.count
        view.exchangeSubview(at: 1, withSubviewAt: subViewCount-1)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

}
