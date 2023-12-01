//
//  MockSignUpGateway.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

struct MockSignUpGateway: SignUpGateway {
    
    func createAnUser(_ user: User) -> AnyPublisher<Result<Void, Error>, Never> {
        let db = MockUserDB.shared
        db.users.append(user)
        return Just(Result.success(())).eraseToAnyPublisher()
    }
    
}
