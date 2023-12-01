//
//  SignUpGateway.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

protocol SignUpGateway {
    func createAnUser(_ user: User) -> AnyPublisher<Result<Void, Error>, Never>
}
