//
//  SignUpUseCase.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

protocol SignUpUseCase {
    func createAnUser(_ user: User) -> AnyPublisher<Result<Void, Error>, Never>
}

struct SignUpUseCaseImpl: SignUpUseCase {
    
    private let gateway: SignUpGateway
    
    init(gateway: SignUpGateway) {
        self.gateway = gateway
    }
    
    func createAnUser(_ user: User) -> AnyPublisher<Result<Void, Error>, Never> {
        gateway.createAnUser(user)
    }
    
}
