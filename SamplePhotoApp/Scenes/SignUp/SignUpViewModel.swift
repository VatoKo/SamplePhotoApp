//
//  SignUpViewModel.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

protocol SignUpViewModel: AnyObject {
    var email: String? { get set }
    var password: String? { get set }
    var age: Int? { get set }
    var emailValidity: AnyPublisher<Validity, Never> { get }
    var passwordValidity: AnyPublisher<Validity, Never> { get }
    var ageValidity: AnyPublisher<Validity, Never> { get }
    var signUpResult: AnyPublisher<Result<User, Error>, Never> { get }
    func createAnUser()
}

class SignUpViewModelImpl: SignUpViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    
    private let signUpUseCase: SignUpUseCase
    private let emailValidator: AnyValidator<String?>
    private let passwordValidator: AnyValidator<String?>
    private let ageValidator: AnyValidator<Int?>
    
    private let signUpResultPublisher = PassthroughSubject<Result<User, Error>, Never>()
    var signUpResult: AnyPublisher<Result<User, Error>, Never> { signUpResultPublisher.eraseToAnyPublisher() }
    
    private let emailValidityPublisher = PassthroughSubject<Validity, Never>()
    var emailValidity: AnyPublisher<Validity, Never> { emailValidityPublisher.eraseToAnyPublisher() }
    private let passwordValidityPublisher = PassthroughSubject<Validity, Never>()
    var passwordValidity: AnyPublisher<Validity, Never> { passwordValidityPublisher.eraseToAnyPublisher() }
    private let ageValidityPublisher = PassthroughSubject<Validity, Never>()
    var ageValidity: AnyPublisher<Validity, Never> { ageValidityPublisher.eraseToAnyPublisher() }
    
    var email: String?
    var password: String?
    var age: Int?
    
    init(
        signUpUseCase: SignUpUseCase,
        emailValidator: AnyValidator<String?>,
        passwordValidator: AnyValidator<String?>,
        ageValidator: AnyValidator<Int?>
    ) {
        self.signUpUseCase = signUpUseCase
        self.emailValidator = emailValidator
        self.passwordValidator = passwordValidator
        self.ageValidator = ageValidator
    }
    
    func createAnUser() {
        let emailValidity = emailValidator.validate(email)
        let passwordValidty = passwordValidator.validate(password)
        let ageValidity = ageValidator.validate(age)
        emailValidityPublisher.send(emailValidity)
        passwordValidityPublisher.send(passwordValidty)
        ageValidityPublisher.send(ageValidity)
        
        if case .invalid(_) = emailValidity {
            return
        }
        if case .invalid(_) = passwordValidty {
            return
        }
        if case .invalid(_) = ageValidity {
            return
        }
        
        let user = User(email: email!, password: password!, age: age!)
        signUpUseCase.createAnUser(user).sink { [weak self] result in
            guard let self else { return }
            switch result {
            case .success():
                self.signUpResultPublisher.send(.success(user))
            case .failure(let error):
                self.signUpResultPublisher.send(.failure(error))
            }
        }.store(in: &cancellables)
    }
}

extension SignUpViewModelImpl {
    
    struct EmptyFieldsError: LocalizedError {
        var errorDescription: String? { "Field must not be empty" }
    }
    
}
