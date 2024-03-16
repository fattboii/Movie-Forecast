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

@MainActor
final class SignUpViewModel: ObservableObject {
    //variable for email and password entered in textfields
    @Published var email: String = ""
    @Published var password: String = ""
    
    //boolean function that checks if user can sign up
    func canSignUp() -> Bool{
        //checks if the email or password is emtpy
        guard !email.isEmpty, !password.isEmpty else{
            return false
        }
        
        //if password and email are not empty it will try to sign up user through firebase
        //returns true if creating user is successful
        //returns false if creating user fails
            Task{
                do{
                    //trys to create user in firebase
                    let returnUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                    print(returnUserData)
                    print("user created")
                    return true
                } catch {
                    print("ERROR \(error)")
                    return false
                }
            }
        return true
    }
    
}


struct SignUpView: View{
    
    @Binding var currentViewShowing: AuthProcess
    
    @StateObject private var viewModel = SignUpViewModel()
    
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
                        TextField("Email", text: $viewModel.email)
                        
                        Spacer()
                        //checks if email count is greater than 0
                        if(viewModel.email.count != 0){
                            //if email meets requirements image is a green check mark
                            //if email does not meet requirements image is a red X
                            Image(systemName: viewModel.email.isValidEmail() ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundStyle(viewModel.email.isValidEmail() ? Color.green : Color.red)
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
                        SecureField("Password", text: $viewModel.password)
                        
                        Spacer()
                        
                        //adds image if password is entered or count is not 0
                        if(viewModel.password.count != 0) {
                            //if password meets requirements image is a green checkmark
                            //if password does not meet requirements image is a red X
                            Image(systemName: isValidPassword(viewModel.password) ? "checkmark" : "xmark")
                                .fontWeight(.bold)
                                .foregroundStyle(isValidPassword(viewModel.password) ? Color.green : Color.red)
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
                        .alert("Email or Password field is empty", isPresented: $credentialsErrorShowing, actions: {})
                    
                    Button("Already have an account?", action: showLoginView)
                    
                }.padding().background(
                    RoundedRectangle(cornerRadius: 15).fill(Color(hex: "EAFBFC"))
                ).padding()
                        
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
        let signedUp = viewModel.canSignUp()
        print("return value: \(signedUp)")
        if signedUp {
            showLoginView()
        }else{
            credentialsErrorShowing = true
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
