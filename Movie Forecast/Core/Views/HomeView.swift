//
//  HomeView.swift
//  Movie Forecast
//
//  Created by Josue on 10/02/24.
//

import SwiftUI
//import Firebase

struct HomeView: View{
    
//    @Binding var viewShowing: String
    var body: some View{
        NavigationStack {
            ScrollView {
                HStack {
                    Text("Now Playing")
                        .font(.title)
                        .bold()
                        .padding(.leading, 15)
                    Spacer()
                }
                ScrollView(.horizontal) {
                    HStack {
                        Text("IMAGEN 1")
                            .frame(width: 225, height: 400)
                            .background(.red)
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.horizontal, 5)
                        Text("IMAGEN 2")
                            .frame(width: 225, height: 400)
                            .background(.purple)
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.horizontal, 5)
                        Text("IMAGEN 3")
                            .frame(width: 225, height: 400)
                            .background(.cyan)
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.horizontal, 5)
                    }.padding(.horizontal, 10)
                }.scrollIndicators(.hidden)
                
                Text("Upcoming")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)
                ScrollView(.horizontal) {
                    HStack {
                        Text("IMAGEN 1")
                            .frame(width: 400, height: 200)
                            .background(.red)
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.horizontal, 5)
                        Text("IMAGEN 2")
                            .frame(width: 400, height: 200)
                            .background(.purple)
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.horizontal, 5)
                        Text("IMAGEN 3")
                            .frame(width: 400, height: 200)
                            .background(.cyan)
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.horizontal, 5)
                    }.padding(.horizontal, 10)
                }
                .scrollIndicators(.hidden)
            }
            .background(Color(hex: "151F24"))
            .navigationTitle("Home")
            
        }
    }
}

#Preview {
    HomeView().preferredColorScheme(.dark)
}

