//
//  LoginConfigurator.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation

protocol LoginConfigurator {
    func configure(_ controller: LoginViewController)
}

struct LoginConfiguratorImpl: LoginConfigurator {
    
    func configure(_ controller: LoginViewController) {
        let authenticationGateway: AuthenticationGateway = MockAuthenticationGateway()
        let authenticationUseCase: AuthenticationUseCase = AuthenticationUseCaseImpl(gateway: authenticationGateway)
        
        let loginViewModel: LoginViewModel = LoginViewModelImpl(
            authenticationUseCase: authenticationUseCase
        )
        
        let loginRouter: LoginRouter = LoginRouterImpl(controller: controller)
        
        controller.viewModel = loginViewModel
        controller.router = loginRouter
    }
    
}
