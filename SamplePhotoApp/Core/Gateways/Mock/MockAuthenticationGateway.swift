//
//  MockAuthenticationGateway.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

struct MockAuthenticationGateway: AuthenticationGateway {
    
    func authenticate(with email: String, and password: String) -> AnyPublisher<Result<Void, Error>, Never> {
        let db = MockUserDB.shared
        return Just(
            db.users.contains(where: { user in user.email == email && user.password == password })
            ? .success(())
            : .failure(UserNotFoundError())
        ).eraseToAnyPublisher()
    }
    
}

extension MockAuthenticationGateway {
    
    struct UserNotFoundError: LocalizedError {
        var errorDescription: String? { "Incorrect email or password" }
    }
    
}
