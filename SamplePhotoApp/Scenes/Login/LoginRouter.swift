//
//  LoginRouter.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import UIKit

protocol LoginRouter {
    func navigateToMainPage()
    func navigateToSignUpPage(delegate: SignUpDelegate)
}

struct LoginRouterImpl: LoginRouter {

    private weak var controller: LoginViewController?
    
    init(controller: LoginViewController?) {
        self.controller = controller
    }
    
    func navigateToMainPage() {
        controller?.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    func navigateToSignUpPage(delegate: SignUpDelegate) {
        let vc = SignUpViewController(configurator: SignUpConfiguratorImpl(delegate: delegate))
        let navContr = UINavigationController(rootViewController: vc)
        navContr.modalPresentationStyle = .pageSheet
        if let sheets = navContr.sheetPresentationController {
            sheets.detents = [.medium()]
            
        }
        controller?.navigationController?.present(navContr, animated: true)
    }
    
}
