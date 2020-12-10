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
}
