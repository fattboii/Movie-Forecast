//
//  SignUpView.swift
//  Movie Forecast
//
//  Created by Josue on 10/02/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct SignUpView: View{
    //varible for email and password textfield
    @State var email: String = ""
    @State var password: String = ""
    
    @Binding var currentViewShowing: AuthProcess
    
    
    //boolean for error message visability
    @State private var credentialsErrorShowing: Bool = false
    
    var body: some View{
        ZStack{
            Color(hex: "151F24" ).edgesIgnoringSafeArea(.all)
            VStack {
                
                Spacer()
                
                //sign up form title hstack
                HStack {
                    Text("Movie Forecast").font(.largeTitle).bold().foregroundStyle(Color.white)
                }
                .padding()
                .padding(.top)
                
                Spacer()
                
                //form content vstack
                VStack {
                    Text("Sign Up")
                        .font(.title)
                        .bold()
                    
                    //email field hstack
                    HStack {
                        Image(systemName: "person.fill")
                        TextField("Email", text: $email)
                        
                        Spacer()
                        //checks if email count is greater than 0
                        if(email.count != 0){
                            //if email meets requirements image is a green check mark
                            //if email does not meet requirements image is a red X
                            Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundStyle(email.isValidEmail() ? Color.green : Color.red)
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                    )
                    .padding()
                    
                    //password field hstack
                    HStack {
                        Image(systemName: "lock.fill")
                        SecureField("Password", text: $password)
                        
                        Spacer()
                        
                        //adds image if password is entered or count is not 0
                        if(password.count != 0) {
                            //if password meets requirements image is a green checkmark
                            //if password does not meet requirements image is a red X
                            Image(systemName: isValidPassword(password) ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundStyle(isValidPassword(password) ? Color.green : Color.red)
                        }
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                    )
                    .padding()
                    
                    //password requirements
                    Text("Password must include:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    Text("- minimum 6 characters long")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    Text("- 1 upper case character")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    Text("- 1 special character")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.bottom)
                    
                    //creates user in firebase
                    Button("Sign Up", action: signUp)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "306599"))
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.bottom)
                    //disables sign up button if email or password textfield is empty
                        .disabled(email.isEmpty || password.isEmpty)
                        .opacity(email.isEmpty || password.isEmpty ? 0.5 : 1)
                        .alert("There may have been a connection error or account may already exist.", isPresented: $credentialsErrorShowing, actions: {})
                    
                    Button("Already have an account?", action: showLoginView)
                        .foregroundColor(.blue)
                    
                }
                .foregroundColor(Color.black)
                .padding()
                .background(Color(hex: "EAFBFC"))
                .clipShape(.rect(cornerRadius: 15))
                .padding()
                
                Spacer()
                Spacer()
            }
        }
    }
}

extension SignUpView {
    private func isValidPassword(_ password: String) -> Bool {
        //minimum 6 characters long
        //1 upper case character
        //1 special character
        let passwordRegex = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        
        return passwordRegex.evaluate(with: password)
    }
    
    //shows login view when user is create in firebase
    private func signUp() {
        Task {
            do {
                //attempts
                let returnUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                showLoginView()
            } catch {
                credentialsErrorShowing = true
            }
        }
    }
    
    //shows login view
    private func showLoginView() {
        withAnimation {
            //changes the view to go to the login page
            self.currentViewShowing = .login
        }
    }
}
