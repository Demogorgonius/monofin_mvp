//
//  CalendarMainPresenter.swift
//  monofin_mvp
//
//  Created by Sergey on 21.11.2020.
//

import Foundation

protocol CalendarOutProtocol: class {
    func success()
    func failure(error: Error)
}

protocol CalendarInProtocol: class {
    init(router: RouterOutputProtocol)
    func addTapped()
}

class CalendarMainPresenter: CalendarInProtocol {
    var router: RouterOutputProtocol?
    required init(router: RouterOutputProtocol) {
        self.router = router
    }
    func addTapped() {
        router?.showAuthSelectViewController()
    }
}
