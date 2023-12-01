//
//  LoginViewModel.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

protocol LoginViewModel: AnyObject {
    var email: String? { get set }
    var password: String? { get set }
    func login()
    var route: AnyPublisher<LoginRoute, Never> { get }
}

enum LoginRoute {
    case main
}

class LoginViewModelImpl: LoginViewModel {
    
    private let authenticationUseCase: AuthenticationUseCase
    
    private var cancellables = Set<AnyCancellable>()
    
    var email: String?
    var password: String?
    
    private let routePublisher = PassthroughSubject<LoginRoute, Never>()
    var route: AnyPublisher<LoginRoute, Never> { routePublisher.eraseToAnyPublisher() }
    
    init(authenticationUseCase: AuthenticationUseCase) {
        self.authenticationUseCase = authenticationUseCase
    }
    
    func login() {
        guard let email, let password else { return }
        authenticationUseCase.authenticate(with: email, and: password).sink { [weak self] result in
            guard let self else { return }
            switch result {
            case .success():
                self.routePublisher.send(.main)
            case .failure(let error):
                print("Login failure", error.localizedDescription)
            }
        }.store(in: &cancellables)
    }
    
}
