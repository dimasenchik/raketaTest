//
//  NewsTableViewCell.swift
//  RaketaTest
//
//  Created by Dima Senchik on 30.09.2020.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var thumbnailImageView: UIImageView!
    @IBOutlet weak private var numberOfCommentsLabel: UILabel!
    
    // MARK: - Properties
    
    var didTapOnThumbnail: VoidHandler?
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnThumbnailImageView))
        thumbnailImageView.isUserInteractionEnabled = true
        thumbnailImageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Public methods
    
    func configure(with model: NewsDomainModel) {
        dateLabel.text = model.createdDate.getElapsedInterval()
        titleLabel.text = model.readableTitle
        numberOfCommentsLabel.text = "Number of comments: \(model.numberOfComments)"
        if let imageURL = URL(string: model.thumbnailImageURL ?? "") {
            thumbnailImageView.load(url: imageURL)
        }
    }
    
    // MARK: - User Interaction
    
    @objc private func tappedOnThumbnailImageView() {
        didTapOnThumbnail?()
    }

}
