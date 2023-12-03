//
//  ImageDetailsConfigurator.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 02.12.23.
//

import Foundation

protocol ImageDetailsConfigurator {
    func configure(_ controller: ImageDetailsController)
}

struct ImageDetailsConfiguratorImpl: ImageDetailsConfigurator {
    
    private let imageData: ImageData
    
    init(imageData: ImageData) {
        self.imageData = imageData
    }
    
    func configure(_ controller: ImageDetailsController) {
        let imageDetailsViewModel: ImageDetailsViewModel = ImageDetailsViewModelImpl(imageData: imageData)
        
        controller.viewModel = imageDetailsViewModel
    }
    
}
