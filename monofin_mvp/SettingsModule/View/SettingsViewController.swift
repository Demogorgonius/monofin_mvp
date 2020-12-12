//
//  SettingsViewController.swift
//  monofin_mvp
//
//  Created by Sergey on 13.12.2020.
//

import UIKit

//MARK: - @IBOutlet



//MARK: - Variables

var presenter: SettingsPresenterInputProtocol!
var alert: AlertInputProtocol!

//MARK: - ViewDidLoad

class SettingsViewController: UIViewController {

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
