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
    var emailValidity: AnyPublisher<Validity, Never> { get }
    var passwordValidity: AnyPublisher<Validity, Never> { get }
    func login()
    var route: AnyPublisher<LoginRoute, Never> { get }
    var status: AnyPublisher<String, Never> { get }
}

enum LoginRoute {
    case main
}

class LoginViewModelImpl: LoginViewModel {
    
    private let authenticationUseCase: AuthenticationUseCase
    private let emailValidator: AnyValidator<String?>
    private let passwordValidator: AnyValidator<String?>
    
    private var cancellables = Set<AnyCancellable>()
    
    var email: String?
    var password: String?
    
    private let routePublisher = PassthroughSubject<LoginRoute, Never>()
    var route: AnyPublisher<LoginRoute, Never> { routePublisher.eraseToAnyPublisher() }
    
    private let statusPublisher = PassthroughSubject<String, Never>()
    var status: AnyPublisher<String, Never> { statusPublisher.eraseToAnyPublisher() }
    
    private let emailValidityPublisher = PassthroughSubject<Validity, Never>()
    var emailValidity: AnyPublisher<Validity, Never> { emailValidityPublisher.eraseToAnyPublisher() }
    private let passwordValidityPublisher = PassthroughSubject<Validity, Never>()
    var passwordValidity: AnyPublisher<Validity, Never> { passwordValidityPublisher.eraseToAnyPublisher() }
    
    init(
        authenticationUseCase: AuthenticationUseCase,
        emailValidator: AnyValidator<String?>,
        passwordValidator: AnyValidator<String?>
    ) {
        self.authenticationUseCase = authenticationUseCase
        self.emailValidator = emailValidator
        self.passwordValidator = passwordValidator
    }
    
    func login() {
        let emailValidity = emailValidator.validate(email)
        let passwordValidty = passwordValidator.validate(password)
        emailValidityPublisher.send(emailValidity)
        passwordValidityPublisher.send(passwordValidty)
        
        if case .invalid(_) = emailValidity {
            return
        }
        if case .invalid(_) = passwordValidty {
            return
        }
        
        authenticationUseCase.authenticate(with: email!, and: password!).sink { [weak self] result in
            guard let self else { return }
            switch result {
            case .success():
                self.routePublisher.send(.main)
            case .failure(let error):
                self.statusPublisher.send(error.localizedDescription)
            }
        }.store(in: &cancellables)
    }
    
}
