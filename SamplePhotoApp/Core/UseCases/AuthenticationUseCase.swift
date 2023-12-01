//
//  AuthenticationUseCase.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

protocol AuthenticationUseCase {
    func authenticate(with email: String, and password: String) -> AnyPublisher<Result<Void, Error>, Never>
}

struct AuthenticationUseCaseImpl: AuthenticationUseCase {

    private let gateway: AuthenticationGateway
    
    init(gateway: AuthenticationGateway) {
        self.gateway = gateway
    }
    
    func authenticate(with email: String, and password: String) -> AnyPublisher<Result<Void, Error>, Never> {
        gateway.authenticate(with: email, and: password)
    }
    
}
