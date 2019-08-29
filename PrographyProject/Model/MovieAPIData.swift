//
//  MovieData.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 29/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

// MARK: - MovieResponse

struct MovieResponse: Codable {
    let status: String?
    let statusMessage: String?
    let data: DataClass?

    enum CodingKeys: String, CodingKey {
        case status, data
        case statusMessage = "status_message"
    }
}

// MARK: - DataClass

struct DataClass: Codable {
    let movieCount: Int?
    let limit: Int?
    let movies: [Movie]?

    enum CodingKeys: String, CodingKey {
        case movieCount = "movie_count"
        case limit, movies
    }
}

// MARK: - Movie

struct Movie: Codable {
    let title: String
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case title, rating
    }
}
