//
//  Validator.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 03.12.23.
//

import Foundation

enum Validity {
    case valid
    case invalid(_ error: String)
    
    var errorText: String? {
        switch self {
        case .valid:
            return nil
        case .invalid(let error):
            return error
        }
    }
}

protocol Validator {
    associatedtype Value
    func validate(value: Value) -> Validity
    var eraseToAnyValidator: AnyValidator<Value> { get }
}

extension Validator {
    
    var eraseToAnyValidator: AnyValidator<Value> {
        return AnyValidator { value in
            validate(value: value)
        }
    }
    
}

struct AnyValidator<Value> {
    let validate: (_ value: Value) -> Validity
}
