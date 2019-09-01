//
//  MovieListViewController.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 29/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    // MARK: - IBOutlet UI

    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private var movieListTableView: UITableView!

    // MARK: - Property

    /// * MovieListTableViewCell Type Property Data
    fileprivate struct CellData {
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

    // MARK: - Setting

    private func setMovieListTableView() {
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
        RequestImage.shared.delegate = self
    }
}

extension MovieListViewController: UITableViewDataSource {
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

extension MovieListViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        MovieCommonData.shared.setSelectedMovieData(index: indexPath.row)
        performSegue(withIdentifier: SegueIdentifier.goToMovieDetail, sender: nil)
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return CellHeight.movieListCell
    }
}

extension MovieListViewController: RequestImageDelegate {
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
