//
//  GetFeedRequest.swift
//  RaketaTest
//
//  Created by Dima Senchik on 30.09.2020.
//

final class GetFeedRequest: Requestable {

    typealias ResponseType = FeedResponseModel
    
    var endpoint: String {
        return "/top.json"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String : Any]? {
        return nil
    }
    
}
