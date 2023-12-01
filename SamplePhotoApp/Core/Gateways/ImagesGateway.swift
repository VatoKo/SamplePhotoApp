//
//  ImagesGateway.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation
import Combine

protocol ImagesGateway {
    func getImages() -> AnyPublisher<[ImageData], Error>
}
