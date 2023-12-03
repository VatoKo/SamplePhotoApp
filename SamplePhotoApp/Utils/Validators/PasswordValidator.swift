//
//  PasswordValidator.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 03.12.23.
//

import Foundation

struct PasswordValidator: Validator {
    
    func validate(value: String?) -> Validity {
        guard let value else { return .invalid("Password shouldn't be empty") }
        
        return value.count >= 6 && value.count <= 12 ? .valid : .invalid("Invalid password format")
    }
    
}
