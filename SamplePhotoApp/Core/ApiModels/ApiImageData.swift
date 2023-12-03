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
    let type: String?
    let tags: String?
    let previewURL: String?
    let fullHDURL: String?
    let largeImageURL: String?
    let imageSize: Double?
    let user: String?
    let userImageURL: String?
    let views: Int?
    let likes: Int?
    let comments: Int?
    let downloads: Int?
}

extension ApiImageData {
    
    var toModel: ImageData {
        ImageData(
            id: id,
            type: type,
            tags: tags,
            previewURL: previewURL != nil ? URL(string: previewURL!) : nil,
            imageUrl: {
                if let fullHDURL {
                    return URL(string: fullHDURL)
                } else if let largeImageURL {
                    return URL(string: largeImageURL)
                } else {
                    return nil
                }
            }(),
            imageSize: imageSize,
            user: user,
            userImageURL: userImageURL != nil ? URL(string: userImageURL!) : nil,
            views: views,
            likes: likes,
            comments: comments,
            downloads: downloads
        )
    }
    
}
