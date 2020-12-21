//
//  AuthSelectViewController.swift
//  monofin_mvp
//
//  Created by Sergey on 01.12.2020.
//

import UIKit

class AuthSelectViewController: UIViewController {

    //MARK: - @IBOutlet
    
    @IBOutlet weak var authWithPhoneButton: UIButton!
    @IBOutlet weak var authWithFacebookButton: UIButton!
    @IBOutlet weak var authWithEmailButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var presenter: AuthSelectProtocol!
    var alert: AlertInputProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authWithPhoneButton.layer.cornerRadius = authWithPhoneButton.layer.bounds.height/2
        authWithFacebookButton.layer.cornerRadius = authWithFacebookButton.layer.bounds.height/2
        authWithEmailButton.layer.cornerRadius = authWithEmailButton.layer.bounds.height/2
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = backgroundImageView.bounds
        view.addSubview(blurredEffectView)
        let subViewCount = view.subviews.count
        view.exchangeSubview(at: 1, withSubviewAt: subViewCount-1)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.alpha = 0.5
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Вернуться", style: .plain, target: nil, action: nil)
    }


    //MARK: - @IBAction
    
    @IBAction func authWithPhoneTapped(_ sender: Any) {
        
    }
    
    @IBAction func authWithFacebookTapped(_ sender: Any) {
        
    }
    
    @IBAction func authWithEmailTapped(_ sender: Any) {
        presenter.emailAuthTaped()
    }
    
}
