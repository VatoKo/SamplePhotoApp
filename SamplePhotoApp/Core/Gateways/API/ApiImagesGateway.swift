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
        let queryItems: [URLQueryItem] = [
            .init(name: "key", value: Bundle.main.infoDictionary?["API_KEY"] as? String),
            .init(name: "per_page", value: "200")
        ]
        var urlComponents = URLComponents(string: "https://pixabay.com/api/")!
        urlComponents.queryItems = queryItems
        return Fetcher<ApiPixaBayData>.init(url: urlComponents.url!).fetch().map { data in
            return data.hits.map({ $0.toModel })
        }.eraseToAnyPublisher()
    }
    
}
