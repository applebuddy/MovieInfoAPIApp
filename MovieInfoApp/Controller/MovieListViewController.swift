//
//  MovieListViewController.swift
//  MovieInfoApp
//
//  Created by MinKyeongTae on 29/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    // MARK: - IBOutlet UI

    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private var movieListTableView: UITableView!

    // MARK: - Property

    /// * MovieListTableViewCell Type Property Data
    fileprivate struct CellData {
        static let defaultSectionCount = 1
        static let defaultRowCount = 10
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

        setMovieListTableView()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_: Bool) {
        super.viewWillAppear(true)
        RequestImage.shared.delegate = self
    }

    // MARK: - Method

    // MARK: Setting

    private func setMovieListTableView() {
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
    }

    // MARK: Check

    private func checkImageDataRequest() {
        isImageDataRequested = RequestImage.shared.isImageKeyEmpty() ? false : true
    }
}

// MARK: - Extension

// MARK: UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return CellData.defaultSectionCount
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let moviesData = MovieCommonData.shared.moviesData else { return CellData.defaultRowCount }
        return moviesData.count > CellData.defaultRowCount ? CellData.defaultRowCount : moviesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieListCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.movieListTableViewCell, for: indexPath) as? MovieListTableViewCell,
            let movieData = MovieCommonData.shared.getMovieData(index: indexPath.row) else { return UITableViewCell() }
        movieListCell.configureCell(movieData: movieData)
        return movieListCell
    }
}

// MARK: UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        MovieCommonData.shared.setSelectedMovieData(index: indexPath.row)
        performSegue(withIdentifier: SegueIdentifier.goToMovieDetail, sender: nil)
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return CellHeight.movieListCell
    }
}

// MARK: RequestImageDelegate

extension MovieListViewController: RequestImageDelegate {
    func imageRequestDidBegin() {
        isImageDataRequested = true
    }

    func imageRequestDidFinished(_: UIImage, imageKey _: String) {
        checkImageDataRequest()
    }

    func imageRequestDidError(_ errorDescription: String) {
        checkImageDataRequest()
        presentDefaultAlertController(title: "이미지 로딩 오류", message: "\(errorDescription)")
    }
}
