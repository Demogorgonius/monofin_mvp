//
//  LoginSelectViewController.swift
//  monofin_mvp
//
//  Created by Sergey on 12.12.2020.
//

import UIKit

class LoginSelectViewController: UIViewController {

   //MARK: - @IBOutlet
    
    @IBOutlet weak var phoneLoginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var backImageView: UIImageView!
    
    //MARK: - variables
    
    var presenter: LoginSelectPresenterProtocol!
    
    //MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //change button style
        
        phoneLoginButton.layer.cornerRadius = phoneLoginButton.layer.bounds.height/2
        facebookLoginButton.layer.cornerRadius = facebookLoginButton.layer.bounds.height/2
        emailLoginButton.layer.cornerRadius = emailLoginButton.layer.bounds.height/2
        
        //change background style
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backImageView.bounds
        view.addSubview(blurredEffectView)
        let subViewCount = view.subviews.count
        view.exchangeSubview(at: 1, withSubviewAt: subViewCount-1)

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.alpha = 0.5
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Вернуться", style: .plain, target: nil, action: nil)
    }

    //MARK: - @IBActions
    
    @IBAction func phoneLoginButtonTap(_ sender: Any) {
        
    }
    
    @IBAction func facebookLoginButtonTap(_ sender: Any) {
        
    }
    
    @IBAction func emailLoginButtonTap(_ sender: Any) {
        presenter.emailLoginButtonTap()
    }

}
