//
//  CalendarMainPresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 21.11.2020.
//
import UIKit
import Foundation

protocol CalendarOutProtocol: class {
    func setUser(user: UserInfo)
    func success()
    func failure(error: Error)
}

protocol CalendarInProtocol: class {
    init(view: CalendarOutProtocol, router: RouterInputProtocol)
    func addTapped()
    func setUser()
    
}

class CalendarMainPresenter: CalendarInProtocol {
    
    weak var view: CalendarOutProtocol?
    var router: RouterInputProtocol?
    var email: String?
    var uid: String?
    var userName: String?
    var photoURL: URL?
    var fireBaseAuth: FireBaseInputProtocol?
    
    required init(view: CalendarOutProtocol, router: RouterInputProtocol) {
        
        self.router = router
        self.view = view
        
    }
    
    func addTapped() {
        router?.showAuthSelectViewController()
    }
    
    public func setUser() {
        if UserDefaults.standard.value(forKey: "userEmail") != nil {
            print((UserDefaults.standard.dictionaryRepresentation() as NSDictionary).value(forKey: "userEmail"))
            if let email = UserDefaults.standard.value(forKey: "userEmail") as? String { self.email = email }
            if let uid = UserDefaults.standard.value(forKey: "uid") as? String { self.uid = uid }
            if let userName = UserDefaults.standard.value(forKey: "userName") as? String { self.userName = userName }
            if let photoURL = UserDefaults.standard.value(forKey: "userPhotoUrl") as? URL { self.photoURL = photoURL }
            let user = UserInfo(userName: userName, uid: uid, email: email, photoURL: photoURL)
            self.view?.setUser(user: user)
        } else {
            router?.showAuthSelectViewController()
        }
        
    }
    
    
}
