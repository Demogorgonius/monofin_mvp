//
//  SettingsViewController.swift
//  monofin_mvp
//
//  Created by Sergey on 13.12.2020.
//

import UIKit


class SettingsViewController: UIViewController {
    //MARK: - @IBOutlet
    
    
    
    //MARK: - Variables
    
    var presenter: SettingsPresenterInputProtocol!
    var alert: AlertInputProtocol!
    
    //MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

//MARK: - @IBActions
    
    
//MARK: - Functions
    

}

//MARK: - Extension

extension SettingsViewController: SettingsPresenterOutputProtocol {
    func success() {
        
    }
    
    func failure(error: Error) {
        
    }
    
    
}
