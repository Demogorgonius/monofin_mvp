//
//  ValidationModule.swift
//  monofin_mvp
//
//  Created by Sergey on 22.12.2020.
//

import Foundation

protocol ValidatorInputProtocol: class {
    func checkString(stringType: StringType, string: String) throws -> Bool
}

class ValidatiorClass: ValidatorInputProtocol {
    
    func checkString(stringType: StringType, string: String) throws -> Bool {
        
        switch stringType {
        case .email:
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            let emailResult: Bool = emailPred.evaluate(with: string)
            if !emailResult {
                throw ValidateInputError.wrongSymbolsEmail
            }
        case .password:
            let passwordRegEx = "[A-Z0-9a-z._%+-]{2,64}"
            let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
            let passwordResult: Bool = passwordPred.evaluate(with: string)
            if !passwordResult {
                throw ValidateInputError.passwordIncorrect
            }
        case .userName:
            let userNameRegEx = "[A-Z0-9a-z._%+-]{2,64}"
            let userNamePred = NSPredicate(format: "SELF MATCHES %@", userNameRegEx)
            let userNameResult: Bool = userNamePred.evaluate(with: string)
            if !userNameResult {
                throw ValidateInputError.userNameError
            }
        }
        
        return true
    }
    
}
