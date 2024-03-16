//
//  AuthView.swift
//  Movie Forecast
//
//  Created by Josue on 10/02/24.
//

import SwiftUI

struct AuthView: View{
    
    //variable for login view or sign up view
    @State private var currentViewShowing: AuthProcess = .login
    
    var body: some View{
        
        switch currentViewShowing {
        case .login:
            LoginView(currentViewShowing: $currentViewShowing)
                .transition(.move(edge: .bottom))
        case .signUp:
            SignUpView(currentViewShowing: $currentViewShowing)
                .transition(.move(edge: .top))
        }
    }
}

enum AuthProcess {
    case login
    case signUp
}

struct AuthView_Previews: PreviewProvider{
    static var previews: some View{
        AuthView()
    }
}
//.Alert(action: "")
