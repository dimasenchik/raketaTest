//
//  NewsResponseModel.swift
//  RaketaTest
//
//  Created by Dima Senchik on 30.09.2020.
//

import Foundation

final class NewsResponseModel: Codable {
    
    let title: String
    let created: Int
    let thumbnail: String?
    let url: String?
    let numberOfComments: Int
    
    enum CodingKeys: String, CodingKey {
        case title, created, thumbnail, url
        case numberOfComments = "num_comments"
    }
}

extension NewsResponseModel {
    // Mapping to domain model isn't very useful for our case but will be useful for cases when
    // response model has much more parameters which won't be used on UI
    func mapToDomain() -> NewsDomainModel {
        return NewsDomainModel(readableTitle: title,
                               thumbnailImageURL: thumbnail,
                               previewImageURL: url,
                               numberOfComments: numberOfComments,
                               createdDate: Date(timeIntervalSince1970: TimeInterval(created)))
    }
}
