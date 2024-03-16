//
//  ContentView.swift
//  Movie Forecast
//
//  Created by Josue on 10/02/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @AppStorage("uid") var userID: String?
//    @State var viewShowing: String = ""
    
    var body: some View {
        if let _ = userID {
            NavView()
        } else {
            AuthView()
        }
    }
}

#Preview {
    ContentView()
}


