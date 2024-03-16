//
//  SearchView.swift
//  Movie Forecast
//
//  Created by Josue on 12/03/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack {
            List {
                Text("Coco")
                Text("The incredibles")
                Text("Avengers")
                Text("Loki")
            }
            .searchable(text: $searchText)
        }
    }
}

#Preview {
    SearchView()
}
