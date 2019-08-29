//
//  MovieListTableViewCell.swift
//  PrographyProject
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

    // MARK: - Setting

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isSelected {
            isSelected.toggle()
        }
        // Configure the view for the selected state
    }

    private func setMovieTitleLabel() {
        movieTitleLabel.numberOfLines = 2
        movieTitleLabel.adjustFontSizeWhenTruncated()
    }

    func configureCell(movieData: Movie) {
        movieTitleLabel.text = "\(movieData.title)"
        movieRatingLabel.text = "평점 : \(movieData.rating)"
    }
}
