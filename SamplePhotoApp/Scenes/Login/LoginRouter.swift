//
//  LoginRouter.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import UIKit

protocol LoginRouter {
    func navigateMainPage()
}

struct LoginRouterImpl: LoginRouter {

    private weak var controller: LoginViewController?
    
    init(controller: LoginViewController?) {
        self.controller = controller
    }
    
    func navigateMainPage() {
        controller?.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
}
