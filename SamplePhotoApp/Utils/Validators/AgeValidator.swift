//
//  AgeValidator.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 03.12.23.
//

import Foundation

struct AgeValidator: Validator {
    
    func validate(value: Int?) -> Validity {
        guard let value else { return .invalid("Age shouldn't be empty") }
        
        return value >= 18 && value <= 99 ? .valid : .invalid("Invalid age")
    }
    
}
