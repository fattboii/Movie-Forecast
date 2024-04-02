//
//  MovieInfoView.swift
//  Movie Forecast
//
//  Created by Josue on 01/04/24.
//

import SwiftUI
import URLImage

struct MovieInfoView: View {
    @State var movie: Movie
    var body: some View {
        ScrollView {
            VStack {
                URLImage(movie.backdropURL) {
                    image in image
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 5))
                }
                Text(movie.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                    .font(.title2)
                HStack {
                    if let genre = movie.genres?.first {
                        Text(genre.name.description)
                    } else {
                        Text("Could Not Load Genre")
                            .foregroundStyle(.red)
                    }
                    Text("•")
                    Text(movie.releaseDate.prefix(4))
                    if let runtime = movie.runtime {
                        Text("\(runtime.description) mins")
                    } else {
                        Text("Could Not Load Runtime")
                            .foregroundStyle(.red)
                    }
                    Spacer()
                }
                .foregroundStyle(.secondary)
                .bold()
                Text(movie.overview)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: getMovieInfo)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 0) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .scaleEffect(0.8)
                        .padding(0)
                    Text(String(format: "%.1f", movie.voteAverage) + "/10")
                        .padding(0)
                }
                .bold()
            }
        }
    }
    
}

extension MovieInfoView {
    private func getMovieInfo() {
        Task {
            let result = await TMDBService().getMovie(id: movie.id.description)
            switch result {
            case .success(let movie):
                self.movie.runtime = movie.runtime
                self.movie.genres = movie.genres
            case .failure(let error):
                print(error)
            }
        }
    }
}

//#Preview {
//    MovieInfoView()
//}
