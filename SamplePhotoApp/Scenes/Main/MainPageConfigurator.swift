//
//  MainPageConfigurator.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation

protocol MainPageConfigurator {
    func configure(_ controller: MainViewController)
}

struct MainPageConfiguratorImpl: MainPageConfigurator {
    
    func configure(_ controller: MainViewController) {
        let imagesGateway: ImagesGateway = ApiImagesGateway()
        let imagesUseCase: ImagesUseCase = ImagesUseCaseImpl(gateway: imagesGateway)
        
        let mainViewModel: MainPageViewModel = MainPageViewModelImpl(imagesUseCase: imagesUseCase)
        
        controller.viewModel = mainViewModel
    }
    
}
