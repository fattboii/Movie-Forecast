//
//  Movie.swift
//  Movie Forecast
//
//  Created by Josue on 11/03/24.
//

import Foundation

struct MovieResponse: Decodable{
    let results: [Movie]
}

struct Movie: Decodable{
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let runtime: Int?
}
