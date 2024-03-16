//
//  MyMoviesView.swift
//  Movie Forecast
//
//  Created by Josue on 12/03/24.
//

import SwiftUI

struct MyMoviesView: View {
    var body: some View {
        NavigationStack {
            List{
                HStack {
                    Image(systemName: "heart")
                    Text("Coco")
                }
                HStack {
                    Image(systemName: "heart.fill")
                    Text("Coco")
                }
            }.navigationTitle("Movie Forecast")
        }
    }
}

#Preview {
    MyMoviesView()
}
