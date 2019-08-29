//
//  RequestAPI.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 29/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

enum APIDataType {
    case movies
    case movie
}

class RequestAPI {
    static let shared: RequestAPI = RequestAPI()

    private var baseURL = "​https://yts.lt/api/v2/list_movies.json?"
    private var subURL = ""

    func requestMovieData(rating: Int, dataType: APIDataType, completion: @escaping (MovieResponse?, Bool) -> Void) {
        subURL = "minimum_rating=\(rating)"
        let dataURLString = "\(baseURL)\(subURL)"

        guard let dataURL = URL(string: dataURLString) else {
            debugPrint("Couldn't get dataURL")
            return
        }

        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: dataURL) { data, _, error in

            if let error = error {
                debugPrint("datatask error Occurred: \(error.localizedDescription)")
                completion(nil, false)
                return
            }

            guard let data = data else {
                debugPrint("data error Occurred")
                completion(nil, false)
                return
            }

            do {
                switch dataType {
                case .movie:
                    completion(nil, false)
                case .movies:
                    let moviesAPIResponse: MovieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    completion(moviesAPIResponse, true)
                }
            } catch {
                debugPrint("API Request Failed : \(error.localizedDescription)")
                completion(nil, false)
            }
        }
        dataTask.resume()
    }
}
