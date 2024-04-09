//
//  ShuffleView.swift
//  Movie Forecast
//
//  Created by Josue on 12/03/24.
//

import SwiftUI

struct ShuffleView: View {
    @State private var boo: Bool = false
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
                HStack {
                    Text("Uncut Gems")
                    Spacer()
                    Text("2019 >")
                }
                HStack {
                    Text("1917")
                    Spacer()
                    Text("2019 >")
                }
                HStack {
                    Text("Diary of a Wimpy Kid: Rodrick Rules")
                    Spacer()
                    Text("2011 >")
                }
            }
            
            VStack {
                genres
                Button("Shuffle", action: Shuffle)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    .background(Color(hex: "306599"))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding()
                    .font(.largeTitle)
            }
            .navigationTitle("Shuffle")
            .padding()
            Spacer()
            
        }
    }
    
    //sub views
    var genres: some View {
        VStack {
            HStack {
                Toggle(isOn: $boo ,label: {
                    Text("Action")
                        .font(.footnote)
                })
                Toggle(isOn: $boo ,label: {
                    Text("Comedy")
                        .font(.footnote)
                })
                Toggle(isOn: $boo ,label: {
                    Text("Drama")
                        .font(.footnote)
                })
            }
            HStack {
                Toggle(isOn: $boo ,label: {
                    Text("Science Fiction")
                        .font(.footnote)
                })
                Toggle(isOn: $boo ,label: {
                    Text("Fantasy")
                        .font(.footnote)
                })
                Toggle(isOn: $boo ,label: {
                    Text("Horror")
                        .font(.footnote)
                })
            }
            HStack {
                Toggle(isOn: $boo ,label: {
                    Text("Thriller")
                        .font(.footnote)
                })
                Toggle(isOn: $boo ,label: {
                    Text("Romance")
                        .font(.footnote)
                })
                Toggle(isOn: $boo ,label: {
                    Text("Adventure")
                        .font(.footnote)
                })
            }
        }
    }
}

extension ShuffleView {
    private func Shuffle() {
        ///chat gpt reccomends movies
    }
}

#Preview {
    ShuffleView()
}
