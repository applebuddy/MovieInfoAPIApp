//
//  MovieDetailTableViewCell.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 02/09/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
    // MARK: - IBOutlet UI

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var summaryTextView: UITextView!

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

    func configureCell(movieData: Movie) {
        titleLabel.text = "\(movieData.title)"
        ratingLabel.text = "평점 : \(movieData.rating)"
        titleImageView.setThumbnailImageFromServerURL(movieData.image, placeHolder: ImageData.thumbnailPlaceHolder)
        summaryTextView.text = "\(movieData.summary)"
    }
}
