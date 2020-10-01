//
//  FeedMainViewModel.swift
//  RaketaTest
//
//  Created by Dima Senchik on 30.09.2020.
//

import Foundation

protocol FeedMainViewModelProtocol {
    var fetchOffset: Int { get }
    var currentPageNumber: Int { get set }
    var fetchedNews: [NewsDomainModel] { get set }
    var availableNews: [NewsDomainModel] { get set }
    var didUpdateData: VoidHandler? { get set }
    var didGetErrorMessage: ((String) -> Void)? { get set }
    func fetchAllNews()
    func preFetchNews()
}

final class FeedMainViewModel: FeedMainViewModelProtocol {
    
    // MARK: - Variables
    
    var fetchOffset: Int {
        return 25
    }
    
    var currentPageNumber: Int = 1
    
    var fetchedNews: [NewsDomainModel] = [] {
        didSet {
            availableNews = Array(fetchedNews.prefix(fetchOffset))
        }
    }
    
    var availableNews: [NewsDomainModel] = [] {
        didSet {
            didUpdateData?()
        }
    }
    
    // MARK: - Callbacks
    
    var didUpdateData: VoidHandler?
    var didGetErrorMessage: ((String) -> Void)?
    
    // MARK: - Public methods
    
    func fetchAllNews() {
        FeedService.fetchNews { [weak self] responseData, responseError in
            DispatchQueue.main.async {
                if let responseData = responseData {
                    self?.fetchedNews = responseData
                } else if let responseError = responseError {
                    self?.didGetErrorMessage?(responseError.localizedDescription)
                }
            }
        }
    }
    
    func preFetchNews() {
        availableNews.append(contentsOf: fetchedNews)
        currentPageNumber += 1
    }
}
