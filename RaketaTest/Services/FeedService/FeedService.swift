//
//  FeedService.swift
//  RaketaTest
//
//  Created by Dima Senchik on 30.09.2020.
//

final class FeedService {
    
    // MARK: - Public methods
    
    static func fetchNews(completion: @escaping ([NewsDomainModel]?, Error?) -> Void) {
        _ = Network.request(req: GetFeedRequest()) { result in
            switch result {
            case .success(let news):
                let mappedNews = news.data.children.map { $0.data.mapToDomain() }
                completion(mappedNews, nil)
            case .cancel(let error):
                completion(nil, error)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}
