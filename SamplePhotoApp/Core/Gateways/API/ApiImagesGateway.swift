//
//  ApiImagesGateway.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

struct ApiImagesGateway: ImagesGateway {
    
    func getImages() -> AnyPublisher<[ImageData], Error> {
        let url = URL(string: "https://pixabay.com/api/?key=41010857-2f1b382daeef02eb708cd4b16")!
        return Fetcher<ApiPixaBayData>.init(url: url).fetch().map { data in
            return data.hits.map({ $0.toModel })
        }.eraseToAnyPublisher()
    }
    
}
