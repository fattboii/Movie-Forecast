//
//  ProfileView.swift
//  Movie Forecast
//
//  Created by Josue on 18/02/24.
//

import SwiftUI

struct ProfileView: View {
    
    @AppStorage("uid") var userID: String?
    
    var body: some View {
        NavigationView{
            List{
                Text("User ID: add userid")
            }
            .navigationTitle("Profile")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Image(systemName: "gear").font(.headline)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
