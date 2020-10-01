//
//  FeedMainViewController.swift
//  RaketaTest
//
//  Created by Dima Senchik on 30.09.2020.
//

import UIKit

final class FeedMainViewController: UIViewController, Alertable {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var contentTableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Properties
    
    private var viewModel: FeedMainViewModelProtocol = FeedMainViewModel()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        viewModel.fetchAllNews()
        
        viewModel.didUpdateData = { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.contentTableView.reloadData()
        }
        
        viewModel.didGetErrorMessage = { [weak self] errorMessage in
            self?.displayError(errorMessage)
        }
    }
    
    // MARK: - Private methods
    
    private func configureTableView() {
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didRefreshData), for: .valueChanged)
    }
    
    // MARK: - User Interaction
    
    @objc private func didRefreshData() {
        viewModel.fetchAllNews()
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension FeedMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.availableNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell",
                                                 for: indexPath) as! NewsTableViewCell
        cell.configure(with: viewModel.availableNews[indexPath.row])
        cell.didTapOnThumbnail = { [weak self] in
            guard let strongSelf = self else { return }
            // To tell the truth, I didn't find full picture but this URL sometimes has image too.
            if let imageURL = URL(string: strongSelf.viewModel.availableNews[indexPath.row].previewImageURL ?? "") {
                UIApplication.shared.open(imageURL)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (viewModel.fetchOffset * viewModel.currentPageNumber) - 1 {
            viewModel.preFetchNews()
        }
    }
}
