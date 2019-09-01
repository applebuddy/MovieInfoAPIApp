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

    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var movieDetailTableView: UITableView!

    // MARK: - Property

    fileprivate struct CellData {
        static let defaultSectionCount = 1
        static let defaultRowCount = 1
    }

    private var isImageDataRequested: Bool = false {
        willSet {
            DispatchQueue.main.async {
                if newValue {
                    self.activityIndicatorView.startAnimating()
                } else {
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        movieDetailTableView.delegate = self
        movieDetailTableView.dataSource = self
    }

    // MARK: - Method

    // MARK: Setting
}

// MARK: - Extension

// MARK: UITableViewDelegate

extension MovieDetailViewController: UITableViewDelegate {
    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: UITableViewDataSource

extension MovieDetailViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return CellData.defaultSectionCount
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return CellData.defaultRowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieDetailCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.movieDetailTableViewCell, for: indexPath) as? MovieDetailTableViewCell,
            let movieData = MovieCommonData.shared.selectedMovieData else { return UITableViewCell() }

        movieDetailCell.configureCell(movieData: movieData)
        return movieDetailCell
    }
}

// MARK: RequestImageDelegate

extension MovieDetailViewController: RequestImageDelegate {
    func imageRequestDidBegin() {
        isImageDataRequested = true
    }

    func imageRequestDidFinished(_: UIImage) {
        isImageDataRequested = false
    }

    func imageRequestDidError(_ errorDescription: String) {
        isImageDataRequested = false
        presentDefaultAlertController(title: "이미지 로딩 오류", message: "\(errorDescription)")
    }
}
