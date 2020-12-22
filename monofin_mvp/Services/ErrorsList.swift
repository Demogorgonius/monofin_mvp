//
//  ErrorsList.swift
//  monofin_mvp
//
//  Created by Sergey on 09.12.2020.
//

import Foundation


enum ValidateInputError: Error {
    case wrongSymbolsEmail
    case emptyString
    case passwordIncorrect
    case passwordNotMatch
    case userNameError
    case authError
}

extension ValidateInputError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .wrongSymbolsEmail:
            return NSLocalizedString("Вы использовали некорректный адрес e-mail!", comment: "Description of invalid e-mail address")
        case .emptyString:
            return NSLocalizedString("Все поля должны быть заполнены!", comment: "Description of empty string")
        case .passwordIncorrect:
            return NSLocalizedString("Вы использовали неверные символы в поле \"пароль\"!", comment: "Description of incorrect password")
        case .passwordNotMatch:
            return NSLocalizedString("Пароли не совпадают!", comment: "Description of not matching passwords")
        case .userNameError:
            return NSLocalizedString("Ошибка в имени пользователя!", comment: "Description of invalid user name")
        case .authError:
            return NSLocalizedString("Неправильное имя пользователя или пароль!", comment: "Authentification error")
        }
    }
}
