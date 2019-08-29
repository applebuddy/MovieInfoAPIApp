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

    @IBOutlet private var movieListTableView: UITableView!

    // MARK: - Property

    /// * MovieListTableViewCell Type Property Data
    fileprivate struct CellData {
        static let defaultRowCount = 10
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
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let moviesData = MovieCommonData.shared.getMoviesData() else { return CellData.defaultRowCount }
        return moviesData.count > CellData.defaultRowCount ? CellData.defaultRowCount : moviesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieListCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.movieListTableViewCell, for: indexPath) as? MovieListTableViewCell,
            let movieData = MovieCommonData.shared.getMovieAPIData(index: indexPath.row) else { return UITableViewCell() }
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
