//
//  SignUpConfigurator.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation

protocol SignUpConfigurator {
    func configure(_ controller: SignUpViewController)
}

struct SignUpConfiguratorImpl: SignUpConfigurator {

    private let delegate: SignUpDelegate
    
    init(delegate: SignUpDelegate) {
        self.delegate = delegate
    }
    
    func configure(_ controller: SignUpViewController) {
        let signUpGateway: SignUpGateway = MockSignUpGateway()
        let signUpUseCase: SignUpUseCase = SignUpUseCaseImpl(gateway: signUpGateway)
        
        let signUpViewModel: SignUpViewModel = SignUpViewModelImpl(
            signUpUseCase: signUpUseCase,
            emailValidator: EmailValidator().eraseToAnyValidator,
            passwordValidator: PasswordValidator().eraseToAnyValidator,
            ageValidator: AgeValidator().eraseToAnyValidator
        )
        
        controller.viewModel = signUpViewModel
        controller.delegate = delegate
    }
    
}
