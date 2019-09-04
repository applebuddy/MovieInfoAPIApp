//
//  MovieDetailTableViewCell.swift
//  MovieInfoApp
//
//  Created by MinKyeongTae on 02/09/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
    // MARK: - IBOutlet UI

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var titleImageView: UIImageView!
    @IBOutlet private var summaryTextView: UITextView!

    // MARK: - Init

    override func awakeFromNib() {
        super.awakeFromNib()
        setTitleLabel()
        setSummaryTextView()
    }

    // MARK: - Method

    // MARK: Setting

    private func setTitleLabel() {
        titleLabel.titleNumberOfLines()
        titleLabel.adjustFontSizeWhenTruncated()
    }

    private func setSummaryTextView() {
        summaryTextView.textContainerInset =
            UIEdgeInsets(top: 0, left: -summaryTextView.textContainer.lineFragmentPadding, bottom: 0, right: -summaryTextView.textContainer.lineFragmentPadding)
    }

    func setTitleImageView(imageKey: String) {
        titleImageView.setThumbnailImageFromCache(imageKey, placeHolder: ImageData.thumbnailPlaceHolder)
    }

    func configureCell(movieData: Movie) {
        titleLabel.text = "\(movieData.title)"
        ratingLabel.text = "평점 : \(movieData.rating)"
        titleImageView.setThumbnailImageFromServerURL(movieData.image, placeHolder: ImageData.thumbnailPlaceHolder)
        summaryTextView.text = "\(movieData.summary)"
    }
}
