//
//  NavView.swift
//  Movie Forecast
//
//  Created by Josue on 12/03/24.
//

import SwiftUI

struct NavView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
            ShuffleView()
                .tabItem {
                    Image(systemName: "shuffle")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            MyMoviesView()
                .tabItem {
                    Image(systemName: "popcorn.fill")
                }
            LogoutView()
                .tabItem {
                    Image(systemName: "door.left.hand.open")
                }
        }
    }
}

#Preview {
    NavView()
}
