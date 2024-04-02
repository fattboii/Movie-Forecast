//
//  HomeView.swift
//  Movie Forecast
//
//  Created by Josue on 10/02/24.
//

import SwiftUI
import URLImage
//import Firebase

struct HomeView: View{
    @State private var movie: Movie? = nil
    @State private var moviesNowPlaying: MoviesNowPlaying? = nil
    @State private var popularMovies: PopularMovies? = nil
    
    
//    @Binding var viewShowing: String
    var body: some View{
        NavigationStack {
            ScrollView {
                ///now playing
                nowPlayingView(moviesNowPlaying: $moviesNowPlaying)
                ///popular movies
                PopularView(popularMovies: $popularMovies)
            }
            .navigationTitle("Home")
            .scrollIndicators(.hidden)
            
        }
        .background(Color(hex: "151F24"))
        
        .onAppear{
            ///Gets movies now playing in theaters
            Task {
                let result = await TMDBService().fetchNowPlayingMovies()
                switch result {
                case .success(let movies):
                    self.moviesNowPlaying = movies
                case .failure(let error):
                    print(error)
                }
            }
            ///Gets popular movies
            Task {
                let result = await TMDBService().fetchPopularMovies()
                switch result {
                case .success(let movies):
                    self.popularMovies = movies
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

extension HomeView {
    ///Functions
    private func fetchMoviesNowPlaying() {
        Task {
            let result = await TMDBService().fetchNowPlayingMovies()
            switch result {
            case .success(let moviesNowPlaying):
                self.moviesNowPlaying = moviesNowPlaying
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchPopularMovies() {
        Task {
            let result = await TMDBService().fetchPopularMovies()
            switch result {
            case .success(let popularMovies):
                self.popularMovies = popularMovies
            case .failure(let error):
                print(error)
            }
        }
    }
}

///SUBVIEWS
struct nowPlayingView: View {
    @Binding var moviesNowPlaying: MoviesNowPlaying?
    var body: some View {
        VStack {
            
            Text("Now Playing")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                if let nowPlaying = moviesNowPlaying {
                    HStack {
                        ForEach(nowPlaying.results, id: \.self) { movie in
                            NavigationLink(destination: MovieInfoView(movie: movie)){
                                VStack {
                                    URLImage(movie.posterURL) {
                                        image in image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .cornerRadius(8)
                                            .shadow(radius: 4)
                                    }
                                    .frame(width: 204, height: 306)
                                    Text(movie.title)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                    }
                } else {
                    Text("No available for the moment")
                }
            }
            .padding(.leading)
            .scrollIndicators(.hidden)
        }
    }
}
struct PopularView: View {
    @Binding var popularMovies: PopularMovies?
    var body: some View {
        VStack {
            
            Text("Popular")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.leading)
            ScrollView(.horizontal) {
                HStack(alignment: .top) {
                    if let popular = popularMovies {
                        ForEach(popular.results, id: \.self) { movie in
                            NavigationLink(destination: MovieInfoView(movie: movie)) {
                                VStack {
                                    URLImage(movie.backdropURL) {
                                        image in image
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(8)
                                            .shadow(radius: 4)
                                    }
                                    Text(movie.title)
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            .containerRelativeFrame(.horizontal, count: 1, spacing: 20.0)
                        }
                    } else {
                        Text("No available for the moment")
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(.horizontal, 16, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    HomeView().preferredColorScheme(.dark)
}


