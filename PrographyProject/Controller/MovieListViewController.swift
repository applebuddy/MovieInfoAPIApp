//
//  MovieListViewController.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 29/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    // MARK: - Outlet UI

    @IBOutlet private var movieListTableView: UITableView!

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
        guard let moviesData = MovieData.shared.getMoviesData() else { return 10 }
        return moviesData.count > 10 ? 10 : moviesData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieListCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.movieListTableViewCell, for: indexPath) as? MovieListTableViewCell,
            let movieData = MovieData.shared.getMovieAPIData(index: indexPath.row) else { return UITableViewCell() }
        movieListCell.configureCell(movieData: movieData)
        return movieListCell
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        MovieData.shared.setSelectedMovieData(index: indexPath.row)
        performSegue(withIdentifier: SegueIdentifier.goToMovieDetail, sender: nil)
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return CellHeight.movieListCell
    }
}
