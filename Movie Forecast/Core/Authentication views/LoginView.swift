//
//  LoginView.swift
//  Movie Forecast
//
//  Created by Josue on 10/02/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

struct LoginView: View{
    
    @Binding var currentViewShowing: AuthProcess
    @State private var credentialsErrorShowing: Bool = false
    @AppStorage("uid") var userID: String?
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View{
        ZStack{
            Color(hex: "151F24" ).edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                HStack{
                    Text("Movie Forecast").font(.largeTitle).bold().foregroundStyle(Color.white)
                }.padding().padding(.top)
                Spacer()
                VStack{
                    Text("Login").font(.title).bold()
                    
                    HStack{
                        Image(systemName: "person.fill")
                        TextField("Email", text: $email)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                    )
                    .padding()
                    
                    HStack{
                        Image(systemName: "lock.fill")
                        SecureField("Password", text: $password)
                        
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                    )
                    .padding()
                    Button("Login", action: login)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "306599"))
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.bottom)
                        .alert("Incorrect Email or Password entered", isPresented: $credentialsErrorShowing, actions: {})
                    
                    Button(action: {
                        withAnimation{
                            self.currentViewShowing = .signUp
                        }
                    }){
                        Text("Don't have an account?")
                    }
                }.padding().background(
                    RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EAFBFC"))
                ).padding()
                        
                Spacer()
                Spacer()
                
            }
        }
    }
}

extension LoginView{
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let _ = error{
                //show wrong credientials error
                credentialsErrorShowing = true
                return
            }
            if let authResult = authResult {
                print(authResult.user.uid)
                withAnimation{
                    userID = authResult.user.uid
                }
            }
        }
    }
}
