//
//  AuthenticationGateway.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

protocol AuthenticationGateway {
    func authenticate(with email: String, and password: String) -> AnyPublisher<Result<Void, Error>, Never>
}
