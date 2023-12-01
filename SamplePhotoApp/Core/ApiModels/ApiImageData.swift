//
//  ApiImageData.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation

struct ApiPixaBayData: Codable {
    let hits: [ApiImageData]
}

struct ApiImageData: Codable {
    let id: Int64?
    let tags: String?
    let previewURL: String?
    let user: String?
}

extension ApiImageData {
    
    var toModel: ImageData {
        ImageData(id: id, tags: tags, previewURL: previewURL, user: user)
    }
    
}
