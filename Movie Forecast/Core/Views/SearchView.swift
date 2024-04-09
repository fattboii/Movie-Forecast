//
//  SearchView.swift
//  Movie Forecast
//
//  Created by Josue on 12/03/24.
//

import SwiftUI
import URLImage

struct SearchView: View {
    @State private var searchInput: String = ""
    @State private var moviesSearched: MoviesSearched? = nil
    var body: some View {
        NavigationStack {
            List {
                if let movies = moviesSearched {
                    ForEach(movies.results, id: \.self) { movie in
                        NavigationLink(destination: MovieInfoView(movie: movie)){
                            HStack{
                                URLImage(movie.posterURL){
                                    image in image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(.rect(cornerRadius: 5))
                                }
                                .frame(width: 40, height: 70)
                                Text(movie.title)
                                Spacer()
                                Text(movie.releaseDate.prefix(4))
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $searchInput)
            .onChange(of: searchInput, searchMovies)
        }
    }
}


extension SearchView {
    private func searchMovies() {
        Task {
            let result = await TMDBService().searchMovies(for: searchInput)
            switch result {
            case .success(let moviesSearched):
                self.moviesSearched = moviesSearched
            case .failure(let error):
                print(error)
            }
        }
    }
}

#Preview {
    SearchView()
}
