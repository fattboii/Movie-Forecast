//
//  TMDBService.swift
//  Movie Forecast
//
//  Created by Josue on 01/04/24.
//

import Foundation
/// handles all the api call requests
struct TMDBService {
    private let headers: [String: String] = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzZWJiN2RlYTJiNjIyMjM3ZTRlMGFiYTM5MmZiY2NiZiIsInN1YiI6IjY1YmViMDhmMDMxZGViMDE4M2VmODFiNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.PiiLB71NwsqDfAiL7p1pZTq0kmui13oRDHlOlJ1bc7s"
    ]
    
    private let baseAPIURL = "https://api.themoviedb/org/3"
    private let APIMethod = "GET"
    
}

extension TMDBService {
    
    /// collect data for api GET method
    /// - Parameter urlRequest: URL for the API GET request
    /// - Returns: if successful this function will return a json response given by the TMDB api with the information from the given api call
    func getDataFromRequest(urlRequest: URL) async -> Result<Data, Error> {
        
        do {
            var request = URLRequest(url: urlRequest)
            request.httpMethod = APIMethod
            request.allHTTPHeaderFields = headers
            let session = URLSession.shared
            let dataTask = try await session.data(for: request)
            return .success(dataTask.0)
        } catch {
            return .failure(error)
        }
        
    }
    
    /// Search movie from the search bar in the search view
    /// - Parameter id: id of the movie being requested
    /// - Returns: if successful the function returns a json response given by TMDB api with the information of the movie
    func getMovie(id: String) async -> Result<Movie, Error> {
        
        if let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?language=en-US&append_to_response=videos,watch/providors") {
            let result = await getDataFromRequest(urlRequest: url)
            switch result {
            case .success(let data):
                do {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    return .success(movie)
                } catch {
                    return .failure(error)
                }
                
            case .failure(let error):
                return .failure(error)
            }
        } else {
            return .failure(NSError())
        }
    }
    
    //select function or variables and click option + command + /
    /// Search movie from the search bar
    /// - Parameter textSearched: text entered in the search bar
    func searchMovies(for textSearched: String) async -> Result<MoviesSearched, Error> {
        if let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(textSearched)&include_adult=false&language=en-US&page=1") {
            let result = await getDataFromRequest(urlRequest: url)
            switch result {
            case .success(let data):
                do {
                    let moviesSearched = try JSONDecoder().decode(MoviesSearched.self, from: data)
                    return .success(moviesSearched)
                } catch {
                    return .failure(error)
                }
                
            case .failure(let error):
                return .failure(error)
            }
        } else {
            return .failure(NSError())
        }
    }
    
    
    /// Fetches movies now playing in theaters
    /// - Returns: json list of movies currently playing in theaters
    func fetchNowPlayingMovies() async -> Result<MoviesNowPlaying, Error> {
        if let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1") {
            let result = await getDataFromRequest(urlRequest: url)
            switch result {
            case .success(let data):
                do {
                    let moviesNowPlaying = try JSONDecoder().decode(MoviesNowPlaying.self, from: data)
                    return .success(moviesNowPlaying)
                } catch {
                    return .failure(error)
                }
            case .failure(let error):
                return .failure(error)
            }
        } else {
            return .failure(NSError())
        }
    }
    
    func fetchPopularMovies() async -> Result<PopularMovies, Error> {
        if let url = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1") {
            let result = await getDataFromRequest(urlRequest: url)
            switch result {
            case .success(let data):
                do {
                    let popularMovies = try JSONDecoder().decode(PopularMovies.self, from: data)
                    return .success(popularMovies)
                } catch {
                    return .failure(error)
                }
            case .failure(let error):
                return .failure(error)
            }
        } else {
            return .failure(NSError())
        }
    }
    
}
