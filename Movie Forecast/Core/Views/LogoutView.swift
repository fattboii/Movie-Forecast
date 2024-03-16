//
//  LogoutView.swift
//  Movie Forecast
//
//  Created by Josue on 12/03/24.
//

import SwiftUI
import FirebaseAuth

struct LogoutView: View {
    @AppStorage("uid") var userID: String?
    var body: some View {
        NavigationStack {
            VStack {
                Button("Sign Out", action: logOut)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "306599"))
                    .clipShape(.rect(cornerRadius: 10))
                    .padding()
            }.navigationTitle("Movie Forecast")
        }
    }
}


extension LogoutView {
    //logs user out of app and firebase authentication
    private func logOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            userID = nil
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }

    }
}

#Preview {
    LogoutView()
}
