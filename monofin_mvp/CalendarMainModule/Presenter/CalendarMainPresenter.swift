//
//  CalendarMainPresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 21.11.2020.
//
import UIKit
import Foundation

protocol CalendarOutProtocol: class {
    func setUser(user: UserInfo?)
    func success()
    func failure(error: Error)
}

protocol CalendarInProtocol: class {
    init(view: CalendarOutProtocol, router: RouterInputProtocol, fireBaseAuth: FireBaseInputProtocol)
    func addTapped()
    func setUser()
    func getUserProfile()
}

class CalendarMainPresenter: CalendarInProtocol {
    
    weak var view: CalendarOutProtocol?
    var router: RouterInputProtocol?
    var user: UserInfo?
    var fireBaseAuth: FireBaseInputProtocol?
    
    required init(view: CalendarOutProtocol, router: RouterInputProtocol, fireBaseAuth: FireBaseInputProtocol) {

        self.router = router
        self.view = view
        self.fireBaseAuth = fireBaseAuth
        
    }
    
    func addTapped() {
        router?.showAuthSelectViewController()
    }
    
    public func setUser() {
        self.view?.setUser(user: user)
    }
    
    func getUserProfile() {

        fireBaseAuth?.getUserProfile(completionBlock: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let userInfo):
                print("first current user is: \(userInfo.userName)")
                self.user = userInfo
            }
        })
    }
    
}
