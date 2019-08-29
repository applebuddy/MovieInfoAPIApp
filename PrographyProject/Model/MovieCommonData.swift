//
//  MovieData.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 30/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

final class MovieCommonData {
    static let shared: MovieCommonData = MovieCommonData()

    // MARK: - Property

    private var movieAPIData: MovieResponse?
    private var selectedMovieData: Movie?

    // MARK: - Setting

    func setMovieAPIData(movieData: MovieResponse) {
        movieAPIData = movieData
    }

    func setSelectedMovieData(index: Int) {
        guard let movieData = movieAPIData?.data?.movies?[index] else { return }
        selectedMovieData = movieData
    }

    // MARK: - Getting

    func getMoviesData() -> [Movie]? {
        guard let moviesData = movieAPIData?.data?.movies else { return nil }
        return moviesData
    }

    func getMovieAPIData(index: Int) -> Movie? {
        guard let movieData = movieAPIData?.data?.movies?[index] else { return nil }
        return movieData
    }

    func getSelectedMovieData() -> Movie? {
        return selectedMovieData
    }
}
