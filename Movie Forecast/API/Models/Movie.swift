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

struct Movie: Codable, Identifiable, Hashable, Equatable{

    var backdropPath: String?
    var genres: [Genre]?
    var genreIDS: [Int]?
    let id: Int
    let overview: String
    var posterPath: String?
    let releaseDate: String
    var runtime: Int?
    let title: String
    let voteAverage: Double
    var videos: Videos?
    var watchProviders: WatchProviders?

    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    enum CodingKeys: String, CodingKey {
        
        case backdropPath = "backdrop_path"
        case genres
        case genreIDS = "genre_ids"
        case id
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case title
        case voteAverage = "vote_average"
        case videos
        case watchProviders = "watch/providers"
        
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id &&
        lhs.runtime == rhs.runtime &&
        lhs.genres == rhs.genres &&
        lhs.watchProviders == rhs.watchProviders &&
        lhs.videos == rhs.videos
    }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

// MARK: - Genre
struct Genre: Codable, Hashable, Equatable{
    let id: Int
    let name: String
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}


// MARK: - Videos
struct Videos: Codable, Hashable, Equatable{
    let results: [VideoResult]
    static func == (lhs: Videos, rhs: Videos) -> Bool {
        lhs.results == rhs.results
    }
    func hash(into hasher: inout Hasher) { hasher.combine(UUID().uuidString) }
}

// MARK: - Result
struct VideoResult: Codable, Hashable, Equatable{
    let iso639_1, iso3166_1, name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    var videoURL: URL {
        return URL(string: "https://www.youtube.com/watch?v=\(key)")!
    }
    
    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
    static func == (lhs: VideoResult, rhs: VideoResult) -> Bool {
        lhs.key == rhs.key &&
        lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) { hasher.combine(UUID().uuidString) }
}

// MARK: - WatchProviders
struct WatchProviders: Codable, Hashable, Equatable{
    let results: watchProvidersResults
    
    static func == (lhs: WatchProviders, rhs: WatchProviders) -> Bool {
        lhs.results == rhs.results
    }
    func hash(into hasher: inout Hasher) { hasher.combine(UUID().uuidString) }
}

// MARK: - Watch Provider Results
struct watchProvidersResults: Codable, Hashable, Equatable {
    let mx: Providers?
    let us: Providers?
    enum CodingKeys: String, CodingKey {
        case mx = "MX"
        case us = "US"
    }
    static func == (lhs: watchProvidersResults, rhs: watchProvidersResults) -> Bool {
        lhs.mx == rhs.mx &&
        lhs.us == rhs.us
    }
    func hash(into hasher: inout Hasher) { hasher.combine(UUID().uuidString) }
}
// MARK: - Providers
struct Providers: Codable, Hashable, Equatable {

    let buy, rent: [Buy]?
    let flatrate: [Buy]?
    
    static func == (lhs: Providers, rhs: Providers) -> Bool {
        lhs.buy == rhs.buy &&
        lhs.rent == rhs.rent &&
        lhs.flatrate == rhs.flatrate
    }
    func hash(into hasher: inout Hasher) { hasher.combine(UUID().uuidString) }
}

// MARK: - Buy
struct Buy: Codable, Hashable, Equatable {
    
    let logoPath: String
    let providerName: String

    var logoURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/original\(logoPath)")!
    }

    enum CodingKeys: String, CodingKey {
        
        case logoPath = "logo_path"
        case providerName = "provider_name"
        
    }
    
    static func == (lhs: Buy, rhs: Buy) -> Bool {
        lhs.logoPath == rhs.logoPath &&
        lhs.logoURL == rhs.logoURL
    }
    func hash(into hasher: inout Hasher) { hasher.combine(UUID().uuidString) }
    
}

