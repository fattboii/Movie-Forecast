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
                }.toolbarBackground(Color(hex: "0B325B"), for: .tabBar)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.toolbarBackground(Color(hex: "0B325B"), for: .tabBar)
            MyMoviesView()
                .tabItem {
                    Image(systemName: "popcorn.fill")
                }.toolbarBackground(Color(hex: "0B325B"), for: .tabBar)
            LogoutView()
                .tabItem {
                    Image(systemName: "door.left.hand.open")
                }.toolbarBackground(Color(hex: "0B325B"), for: .bottomBar)
        }.tint(Color(hex: "EAFBFC"))
    }
}

#Preview {
    NavView().preferredColorScheme(.dark)
}
