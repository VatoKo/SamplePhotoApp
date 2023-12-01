//
//  MainPageRouter.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation

protocol MainPageRouter {
    func navigateToImageDetails(_ imageData: ImageData)
}

struct MainPageRouterImpl: MainPageRouter {
    
    private weak var controller: MainViewController?
    
    init(controller: MainViewController?) {
        self.controller = controller
    }
    
    func navigateToImageDetails(_ imageData: ImageData) {
        controller?.navigationController?.pushViewController(ImageDetailsController(), animated: true)
    }
    
}
