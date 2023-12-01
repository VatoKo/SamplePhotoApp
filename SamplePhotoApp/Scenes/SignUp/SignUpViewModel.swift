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
    var signUpResult: AnyPublisher<Result<User, Error>, Never> { get }
    func createAnUser()
}

class SignUpViewModelImpl: SignUpViewModel {
    
    private var cancellables = Set<AnyCancellable>()
    
    private let signUpUseCase: SignUpUseCase
    
    private let signUpResultPublisher = PassthroughSubject<Result<User, Error>, Never>()
    var signUpResult: AnyPublisher<Result<User, Error>, Never> { signUpResultPublisher.eraseToAnyPublisher() }
    
    var email: String?
    var password: String?
    var age: Int?
    
    init(signUpUseCase: SignUpUseCase) {
        self.signUpUseCase = signUpUseCase
    }
    
    func createAnUser() {
        guard let email, let password, let age else { signUpResultPublisher.send(.failure(EmptyFieldsError())); return }
        let user = User(email: email, password: password, age: age)
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
