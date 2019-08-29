//
//  MovieData.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 30/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class MovieData {
    static let shared: MovieData = MovieData()

    private var movieAPIData: MovieResponse?
    private var selectedMovieData: Movie?

    func setMovieAPIData(movieData: MovieResponse) {
        movieAPIData = movieData
    }

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

    func setSelectedMovieData(index: Int) {
        guard let movieData = movieAPIData?.data?.movies?[index] else { return }
        selectedMovieData = movieData
    }
}
