//
//  PopularMovies.swift
//  Movie Forecast
//
//  Created by Josue on 01/04/24.
//

import Foundation
///THINK I CAN DELETE
// MARK: - Popular
struct PopularMovies: Codable {
//    let page: Int
//    let results: [PopularMoviesResult]
    let results: [Movie]
//    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
//        case page,
             case results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
    }
}

// MARK: - Result
struct PopularMoviesResult: Codable, Identifiable, Hashable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
