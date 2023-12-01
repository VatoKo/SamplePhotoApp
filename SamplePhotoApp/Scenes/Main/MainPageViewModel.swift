//
//  MainPageViewModel.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

protocol MainPageViewModel: AnyObject {
    var images: AnyPublisher<[ImageData], Never> { get }
    var route: AnyPublisher<MainPageRoute, Never> { get }
    func loadImages()
    func didSelectImage(_ imageData: ImageData)
}

enum MainPageRoute {
    case details(_ imageData: ImageData)
}

class MainPageViewModelImpl: MainPageViewModel {

    private var cancellables = Set<AnyCancellable>()
    
    private let imagesUseCase: ImagesUseCase
    
    private let imagesPublisher = PassthroughSubject<[ImageData], Never>()
    var images: AnyPublisher<[ImageData], Never> { imagesPublisher.eraseToAnyPublisher() }
    
    private let routesPublisher = PassthroughSubject<MainPageRoute, Never>()
    var route: AnyPublisher<MainPageRoute, Never> { routesPublisher.eraseToAnyPublisher() }
    
    init(imagesUseCase: ImagesUseCase) {
        self.imagesUseCase = imagesUseCase
    }
    
    func loadImages() {
        imagesUseCase.getImages().sink { error in
            print(error)
        } receiveValue: { [weak self] images in
            guard let self else { return }
            self.imagesPublisher.send(images)
        }.store(in: &cancellables)
    }
    
    func didSelectImage(_ imageData: ImageData) {
        routesPublisher.send(.details(imageData))
    }
    
}
