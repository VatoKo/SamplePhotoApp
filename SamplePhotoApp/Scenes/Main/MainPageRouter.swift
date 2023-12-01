//
//  MainPageRouter.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation

protocol MainPageRouter {
    func navigateToImageDetails(_ imageData: ImageData)
    func navigateToLoginPage()
}

struct MainPageRouterImpl: MainPageRouter {
    
    private weak var controller: MainViewController?
    
    init(controller: MainViewController?) {
        self.controller = controller
    }
    
    func navigateToImageDetails(_ imageData: ImageData) {
        controller?.navigationController?.pushViewController(ImageDetailsController(), animated: true)
    }
    
    func navigateToLoginPage() {
        let vc = LoginViewController(configurator: LoginConfiguratorImpl())
        controller?.navigationController?.setViewControllers([vc], animated: true)
    }
    
}
