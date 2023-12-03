//
//  ImageDetailsViewModel.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 02.12.23.
//

import Foundation
import Combine

protocol ImageDetailsViewModel: AnyObject {
    var imageDetailsProvider: AnyPublisher<ImageDetailsProvider, Never> { get }
    func loadData()
}

protocol ImageDetailsProvider {
    var url: URL? { get }
    var imageSize: Double? { get }
    var imageType: String? { get }
    var imageTags: [String]? { get }
    var imageAuthor: String? { get }
    var imageAuthorPhotoUrl: URL? { get }
    var numberOfViews: Int? { get }
    var numberOfLikes: Int? { get }
    var numberOfComments: Int? { get }
    var numberOfDownloads: Int? { get }
}

class ImageDetailsViewModelImpl: ImageDetailsViewModel {
    
    private let imageData: ImageData
    
    private let imageDetailsProviderPublisher = PassthroughSubject<ImageDetailsProvider, Never>()
    var imageDetailsProvider: AnyPublisher<ImageDetailsProvider, Never> { imageDetailsProviderPublisher.eraseToAnyPublisher() }
    
    init(imageData: ImageData) {
        self.imageData = imageData
    }
    
    func loadData() {
        imageDetailsProviderPublisher.send(imageData)
    }
    
}
