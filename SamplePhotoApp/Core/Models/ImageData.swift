//
//  ImageData.swift
//  SamplePhotoApp
//
//  Created by Vato Kostava on 01.12.23.
//

import Foundation

struct ImageData: Hashable {
    let id: Int64?
    let type: String?
    let tags: String?
    let previewURL: URL?
    let imageUrl: URL?
    let imageSize: Double?
    let user: String?
    let userImageURL: URL?
    let views: Int?
    let likes: Int?
    let comments: Int?
    let downloads: Int?
}

extension ImageData: ImageDetailsProvider {
    
    var url: URL? {
        imageUrl
    }
    
    var imageType: String? {
        type
    }
    
    var imageTags: [String]? {
        tags?.components(separatedBy: ", ")
    }
    
    var imageAuthor: String? {
        user
    }
    
    var imageAuthorPhotoUrl: URL? {
        userImageURL
    }
    
    var numberOfViews: Int? {
        views
    }
    
    var numberOfLikes: Int? {
        likes
    }
    
    var numberOfComments: Int? {
        comments
    }
    
    var numberOfDownloads: Int? {
        downloads
    }
    
}
