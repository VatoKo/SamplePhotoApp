//
//  SignUpRouter.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation

protocol SignUpRouter {
    func navigateToMainPage()
}

struct SignUpRouterImpl: SignUpRouter {
    
    private weak var controller: SignUpViewController?
    
    init(controller: SignUpViewController?) {
        self.controller = controller
    }
    
    func navigateToMainPage() {
        controller?.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
}
