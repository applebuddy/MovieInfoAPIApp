//
//  MovieDetailViewController.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 29/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    // MARK: - IBOutlet UI

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var movieImageView: UIImageView!
    @IBOutlet private var ratingLabel: UILabel!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleLabel()
        setLabelWithMovieData()
    }

    // MARK: - Setting

    private func setTitleLabel() {
        titleLabel.titleNumberOfLines()
        titleLabel.adjustFontSizeWhenTruncated()
    }

    private func setLabelWithMovieData() {
        guard let movieData = MovieCommonData.shared.selectedMovieData else { return }
        titleLabel.text = movieData.title
        ratingLabel.text = "평점 : \(movieData.rating)"
        movieImageView.setThumbnailImageFromCache(movieData.image, placeHolder: ImageData.thumbnailPlaceHolder)
    }
}
