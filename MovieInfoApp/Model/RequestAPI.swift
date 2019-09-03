//
//  RequestAPI.swift
//  MovieInfoApp
//
//  Created by MinKyeongTae on 29/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

final class RequestAPI {
    static let shared: RequestAPI = RequestAPI()

    // MARK: - Property

    /// * Movie API 요청 시 반응하는 MVC 델리게이션 변수
    weak var delegate: RequestMovieAPIDelegate?

    // MARK: - Method

    // MARK: Request API

    func requestMovieData(rating: Int, completion: @escaping (MovieResponse?) -> Void) {
        delegate?.movieRequestDidBegin()
        /// * API 요청 시 사용하는 URL String Format
        let dataURLString: String = "https://yts.lt/api/v2/list_movies.json?minimum_rating=\(rating)"

        guard let dataURL: URL = URL(string: dataURLString) else {
            let errorString = "couldn't get URL data"
            delegate?.movieRequestDidError(errorString)
            return
        }

        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: dataURL) { data, _, error in

            if let error = error {
                let errorString = "(datatask error Occurred: \(error.localizedDescription))"
                self.delegate?.movieRequestDidError(errorString)
                completion(nil)
                return
            }

            guard let data = data else {
                let errorString = "(data error Occurred)"
                self.delegate?.movieRequestDidError(errorString)
                completion(nil)
                return
            }

            do {
                self.delegate?.movieRequestDidFinished()
                let moviesAPIResponse: MovieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(moviesAPIResponse)
            } catch {
                let errorString = "(API Request Failed : \(error.localizedDescription))"
                self.delegate?.movieRequestDidError(errorString)
                completion(nil)
            }
        }
        dataTask.resume()
    }
}
