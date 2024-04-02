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

//struct Movie: Decodable, Identifiable{
//    let id: Int
//    let title: String
//    let backdropPath: String?
//    let posterPath: String?
//    let overview: String
//    let voteAverage: Double
//    let voteCount: Int
//    let runtime: Int?
//
//    var backdropURL: URL {
//        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
//    }
//    var posterURL: URL {
//        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
//    }
//}
struct Movie: Codable, Identifiable, Hashable, Equatable{
    
//    let adult: Bool
    var backdropPath: String?
//    let belongsToCollection: BelongsToCollection
//    let budget: Int
    var genres: [Genre]?
    var genreIDS: [Int]?
//    let homepage: String
    let id: Int
//    let imdbID, originalLanguage, originalTitle
    let overview: String
//    let popularity: Double
    var posterPath: String?
//    let productionCompanies: [ProductionCompany]
//    let productionCountries: [ProductionCountry]
    let releaseDate: String
//    let revenue
    var runtime: Int?
//    let spokenLanguages: [SpokenLanguage]
//    let status, tagline, 
    let title: String
//    let video: Bool
    let voteAverage: Double
//    let voteCount: Int
    var videos: Videos?
    
//    var description: String {
//        originalTitle.description + "\n" +
//        overview.description + "\n" +
//        adult.description + "\n" +
//        budget.description + "\n" +
//        genres.description + "\n" +
//        homepage.description + "\n" +
//        id.description + "\n" +
//        imdbID.description + "\n" +
//        popularity.description + "\n" +
//        productionCompanies.description + "\n" +
//        productionCountries.description + "\n" +
//        releaseDate.description + "\n" +
//        revenue.description + "\n" +
//        spokenLanguages.description + "\n" +
//        status.description + "\n" +
//        video.description + "\n" +
//        voteAverage.description + "\n" +
//        voteCount.description
//        
//    }

    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    
    enum CodingKeys: String, CodingKey {
//        case adult
        case backdropPath = "backdrop_path"
//        case belongsToCollection = "belongs_to_collection"
        case genres
        case genreIDS = "genre_ids"
        case id
//        case imdbID = "imdb_id"
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
        case overview
//        , popularity
        case posterPath = "poster_path"
//        case productionCompanies = "production_companies"
//        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case runtime
//        case spokenLanguages = "spoken_languages"
//        case status, tagline, 
             case title
        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
        case videos
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id &&
        lhs.runtime == rhs.runtime &&
        lhs.genres == rhs.genres
    }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}

//// MARK: - BelongsToCollection
//struct BelongsToCollection: Codable {
//    let id: Int
//    let name, posterPath, backdropPath: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case posterPath = "poster_path"
//        case backdropPath = "backdrop_path"
//    }
//}

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
//    var id = UUID().uuidString
    let results: [MResult]
    static func == (lhs: Videos, rhs: Videos) -> Bool {
        lhs.results == rhs.results
    }
    func hash(into hasher: inout Hasher) { hasher.combine(UUID().uuidString) }
}

// MARK: - Result
struct MResult: Codable, Hashable, Equatable{
    let iso639_1, iso3166_1, name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
    static func == (lhs: MResult, rhs: MResult) -> Bool {
        lhs.key == rhs.key &&
        lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) { hasher.combine(UUID().uuidString) }
    
}
