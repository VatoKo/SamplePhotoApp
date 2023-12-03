//
//  EmailValidator.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 03.12.23.
//

import Foundation

struct EmailValidator: Validator {
    
    func validate(value: String?) -> Validity {
        guard let value else { return .invalid("Email shouldn't be empty") }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValid = emailPred.evaluate(with: value)
        return isValid ? .valid : .invalid("Invalid email format")
    }
    
    var eraseToAnyValidator: AnyValidator<String?> {
        return AnyValidator { value in
            return validate(value: value)
        }
    }
    
}
