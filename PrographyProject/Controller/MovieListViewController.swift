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

        makeMovieListTableView()
        // Do any additional setup after loading the view.
    }

    // MARK: - Setting

    private func makeMovieListTableView() {
        movieListTableView.dataSource = self
        movieListTableView.delegate = self
    }
}

extension MovieListViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieListCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.movieListTableViewCell, for: indexPath) as? MovieListTableViewCell else { return UITableViewCell() }

        return movieListCell
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        performSegue(withIdentifier: SegueIdentifier.goToMovieDetail, sender: nil)
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return CellHeight.movieListCell
    }
}
