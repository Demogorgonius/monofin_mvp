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
    
//MARK: - Functions
    

}

//MARK: - Extension

extension SettingsViewController: SettingsPresenterOutputProtocol {
    func success() {
        
    }
    
    func failure(error: Error) {
        
    }
    
    
}
