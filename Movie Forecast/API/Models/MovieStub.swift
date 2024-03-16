//
//  MovieStub.swift
//  Movie Forecast
//
//  Created by Josue on 11/03/24.
//

import Foundation


extension Movie{
//    static var stubbedMovies: [Movie]{
////        let response: MovieResponse? = try> Bundle.main.loadAndDecodeJSON(file)
//    }
}

extension Bundle{
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
