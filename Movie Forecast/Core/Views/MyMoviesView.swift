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
                    Text("Coco")
                    Spacer()
                    Text("2017 >")
                    
                }
                HStack {
                    Text("Fight Club")
                    Spacer()
                    Text("1999 >")
                }
            }.navigationTitle("My Movies")
        }
    }
}

#Preview {
    MyMoviesView()
}
