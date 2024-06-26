//
//  MovieInfoView.swift
//  Movie Forecast
//
//  Created by Josue on 01/04/24.
//

import SwiftUI
import URLImage
import WebKit
import UIKit

struct MovieInfoView: View {
    @State var movie: Movie
    
    @State private var isFilled = false
    @State private var movieInfoLoaded = false
    @State private var isShowingVideoPlayer = false
    
    var body: some View {
        ScrollView {
            VStack {
                heading
                movieInfo
                trailers
            }
        }
        .scrollIndicators(.hidden)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
                    if !movieInfoLoaded { // Check if movie info hasn't been loaded yet
                        print("Going to get movie info")
                        getMovieInfo()
                        movieInfoLoaded = true
                    }
                })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    // Toggle the state when the button is clicked
                    self.isFilled.toggle()
                }) {
                    // Use conditional rendering based on the state to display different images
                    Image(systemName: isFilled ? "heart.fill" : "heart")
                }
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
                self.movie.watchProviders = movie.watchProviders
                self.movie.videos = movie.videos
                print(movie)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    //views
    var heading: some View {
        VStack {
            
                URLImage(movie.backdropURL) {
                    image in image
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 10))
                }
                Text(movie.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .bold()
                    .font(.title2)
                    .padding(.top, 5)
                
                ///Rating
                HStack(spacing: 0) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                        .scaleEffect(0.8)
                        .padding(0)
                    Text(String(format: "%.1f", movie.voteAverage) + "/10")
                        .padding(0)
                    
                }
                .padding(.vertical, 1)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
                ///genre, release date, and runtime
                HStack {
                    if let genre = movie.genres?.first {
                        Text(genre.name.description)
                    } else {
                        Text("Could Not Load Genre")
                            .foregroundStyle(.red)
                    }
                    Text("•")
                    Text(movie.releaseDate.prefix(4))
                    Text("•")
                    if let runtime = movie.runtime {
                        Text("\(runtime.description) mins")
                    } else {
                        Text("Could Not Load Runtime")
                            .foregroundStyle(.red)
                    }
                    Spacer()
                }
                .padding(.bottom, 3)
                .bold()
                .foregroundStyle(.secondary)
        }
    }
    var movieInfo: some View {
        VStack {
            Text(movie.overview)
                .padding(.bottom, 5)
                
                Text("Where to watch:")
                    .bold()
                    .padding(.bottom, 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if let providersUS = movie.watchProviders?.results.us {
                    
                    if let buy = providersUS.buy {
                        
                        Text("Buy:")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(buy, id: \.self) { logo in
                                    URLImage(logo.logoURL){
                                        image in image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 10))
                                    }
                                    .frame(width: 45, height: 45)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                    if let rent = providersUS.rent {
                        
                        Text("Rent:")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(rent, id: \.self) { logo in
                                    URLImage(logo.logoURL){
                                        image in image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 10))
                                    }
                                    .frame(width: 45, height: 45)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                    if let rate = providersUS.flatrate {
                        
                        Text("Subscription:")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
    
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(rate, id: \.self) { logo in
                                    URLImage(logo.logoURL){
                                        image in image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 10))
                                    }
                                    .frame(width: 45, height: 45)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                } else {
                    Text("There is no option available for video-on-demand.")
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            
        }
        .padding(.bottom, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
                    
    var trailers: some View {
        VStack {
            Text("Trailers / Videos:")
                .bold()
                .font(.title2)
                .padding(.bottom, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
            if let youtube = movie.videos?.results {
                ForEach(youtube, id: \.self) {
                    video in
                    HStack {
                        Text(video.name)
                        Spacer()
                        Button(action: {
                            playVideo(url: video.videoURL)
//                            isShowingVideoPlayer.toggle()
                        }){
                            Image(systemName: "play.fill")
                        }
//                        .sheet(isPresented: $isShowingVideoPlayer) {
//                            VideoPlayerWebView(videoURL: video.videoURL)
//                                }
                    }
                }
            }
        }
        .padding(10)
        
    }
    
    private func playVideo(url: URL) {
                UIApplication.shared.open(url)
    }
//    struct VideoPlayerWebView: View {
//        let videoURL: URL
//
//        var body: some View {
//            WebView(urlLink: videoURL)
//                .edgesIgnoringSafeArea(.all)
//        }
//    }
//    struct WebView: UIViewRepresentable {
//        let urlLink: URL
//
//        func makeUIView(context: Context) -> WKWebView {
//            let webView = WKWebView()
//            webView.load(URLRequest(url: urlLink))
//            return webView
//        }
//
//        func updateUIView(_ uiView: WKWebView, context: Context) {
//            // Update the web view if needed
//        }
//    }
}

//#Preview {
//    MovieInfoView()
//}
