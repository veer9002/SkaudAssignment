//
//  Image.swift
//  SkaudAssignment
//
//  Created by Manish Sharma on 07/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import Foundation

// MARK: - Image
struct ImageResponse: Decodable {
    let total, totalHits: Int?
    let hits: [Hit]?
}

// MARK: - Hit
struct Hit: Decodable {
    let id: Int?
    let pageURL: String?
    let type: TypeEnum?
    let tags: String?
    let previewURL: String?
    let previewWidth, previewHeight: Int?
    let webformatURL: String?
    let webformatWidth, webformatHeight: Int?
    let largeImageURL: String?
    let imageWidth, imageHeight, imageSize, views: Int?
    let downloads, favorites, likes, comments: Int?
    let userID: Int?
    let user: String?
    let userImageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, favorites, likes, comments
        case userID = "user_id"
        case user, userImageURL
    }
}

enum TypeEnum: String, Decodable {
    case photo = "photo"
}
