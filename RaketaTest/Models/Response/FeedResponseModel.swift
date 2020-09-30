//
//  FeedResponseModel.swift
//  RaketaTest
//
//  Created by Dima Senchik on 30.09.2020.
//

import Foundation

final class FeedResponseModel: Codable {
    
    let kind: String
    let data: FeedDataResponseModel
    
    init(kind: String, data: FeedDataResponseModel) {
        self.kind = kind
        self.data = data
    }
}

final class FeedDataResponseModel: Codable {
    
    let children: [FeedChildrenResponseModel]
    
    init(children: [FeedChildrenResponseModel]) {
        self.children = children
    }
}

final class FeedChildrenResponseModel: Codable {
    
    let kind: String
    let data: NewsResponseModel
}
