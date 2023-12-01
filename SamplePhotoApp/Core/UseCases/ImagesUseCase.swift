//
//  ImagesUseCase.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

protocol ImagesUseCase {
    func getImages() -> AnyPublisher<[ImageData], Error>
}

struct ImagesUseCaseImpl: ImagesUseCase {

    private let gateway: ImagesGateway
    
    init(gateway: ImagesGateway) {
        self.gateway = gateway
    }
    
    
    func getImages() -> AnyPublisher<[ImageData], Error> {
        gateway.getImages()
    }
    
}
