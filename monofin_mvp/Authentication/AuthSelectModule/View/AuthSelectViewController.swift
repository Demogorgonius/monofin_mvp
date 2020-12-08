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
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.alpha = 0.5
    }


    //MARK: - @IBAction
    
    @IBAction func authWithPhoneTapped(_ sender: Any) {
        
    }
    
    @IBAction func authWithFacebookTapped(_ sender: Any) {
        
    }
    
    @IBAction func authWithEmailTapped(_ sender: Any) {
        
    }
    
}
