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

    private var movieResponse: MovieResponse?
    private var moviesData: [Movie]?
    private(set) var selectedMovieData: Movie?

    // 임시적으로 섬네일 이미지의 URL값과 이미지를 저장해두는 이미지캐시 변수
    var thumbnailImageCache = NSCache<NSString, UIImage>()

    // MARK: - Setting

    func setMovieAPIData(movieData: MovieResponse) {
        movieResponse = movieData
        moviesData = movieData.data?.movies?.sorted { (movie, movie2) -> Bool in
            movie.rating < movie2.rating
        }
    }

    func setSelectedMovieData(index: Int) {
        guard let movieData = self.moviesData?[index] else { return }
        selectedMovieData = movieData
    }

    // MARK: - Getting

    func getMoviesData() -> [Movie]? {
        guard let moviesData = self.moviesData else { return nil }
        return moviesData
    }

    func getMovieData(index: Int) -> Movie? {
        guard let movieData = self.moviesData?[index] else { return nil }
        return movieData
    }
}
