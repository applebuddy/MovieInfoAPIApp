//
//  MovieListTableViewCell.swift
//  MovieInfoApp
//
//  Created by MinKyeongTae on 29/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    // MARK: - IBOutlet UI

    @IBOutlet private var movieImageView: UIImageView!
    @IBOutlet private var movieTitleLabel: UILabel!
    @IBOutlet private var movieRatingLabel: UILabel!

    // MARK: - Init

    override func awakeFromNib() {
        super.awakeFromNib()
        setMovieTitleLabel()
    }

    override func prepareForReuse() {
        movieTitleLabel.text = ""
        movieRatingLabel.text = ""
        movieImageView.image = ImageData.thumbnailPlaceHolder
    }

    // MARK: - Method

    // MARK: Setting

    override func setSelected(_: Bool, animated _: Bool) {
        if isSelected {
            isSelected.toggle()
        }
    }

    private func setMovieTitleLabel() {
        movieTitleLabel.titleNumberOfLines()
        movieTitleLabel.adjustFontSizeWhenTruncated()
    }

    func configureCell(movieData: Movie) {
        movieTitleLabel.text = "\(movieData.title)"
        movieRatingLabel.text = "평점 : \(movieData.rating)"
        movieImageView.setThumbnailImageFromServerURL(movieData.image, placeHolder: ImageData.thumbnailPlaceHolder)
    }
}
