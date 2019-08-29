//
//  RequestAPI.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 29/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class RequestAPI {
    static let shared: RequestAPI = RequestAPI()

    weak var delegate: RequestMovieAPIDelegate?

    func requestMovieData(rating: Int, completion: @escaping (MovieResponse?) -> Void) {
        delegate?.movieRequestDidBegin(self)
        let dataURLString: String = "https://yts.lt/api/v2/list_movies.json?minimum_rating=\(rating)"

        guard let dataURL: URL = URL(string: dataURLString) else {
            let errorString = "couldn't get URL data"
            delegate?.movieRequestDidError(self, errorString)
            return
        }
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: dataURL) { data, _, error in

            if let error = error {
                let errorString = "datatask error Occurred: \(error.localizedDescription)"
                self.delegate?.movieRequestDidError(self, errorString)
                completion(nil)
                return
            }

            guard let data = data else {
                let errorString = "data error Occurred"
                self.delegate?.movieRequestDidError(self, errorString)
                completion(nil)
                return
            }

            do {
                self.delegate?.movieRequestDidFinished(self)
                let moviesAPIResponse: MovieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(moviesAPIResponse)
            } catch {
                let errorString = "API Request Failed : \(error.localizedDescription)"
                self.delegate?.movieRequestDidError(self, errorString)
                completion(nil)
            }
        }
        dataTask.resume()
    }
}
