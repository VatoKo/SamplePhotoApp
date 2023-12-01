//
//  MainPageViewModel.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

protocol MainPageViewModel: AnyObject {
    func loadImages()
}

class MainPageViewModelImpl: MainPageViewModel {

    private var cancellables = Set<AnyCancellable>()
    
    private let imagesUseCase: ImagesUseCase
    
    init(imagesUseCase: ImagesUseCase) {
        self.imagesUseCase = imagesUseCase
    }
    
    func loadImages() {
        imagesUseCase.getImages().sink { error in
            print(error)
        } receiveValue: { images in
            print(images)
        }.store(in: &cancellables)

    }
    
}
