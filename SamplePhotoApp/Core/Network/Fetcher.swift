//
//  Fetcher.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

class Fetcher<ResponseObject: Decodable> {
    
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func fetch() -> AnyPublisher<ResponseObject, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response: URLResponse) in
                guard let response = response as? HTTPURLResponse, (200...299) ~= response.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ResponseObject.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
}
