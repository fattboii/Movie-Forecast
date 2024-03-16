//
//  AuthenticationManager.swift
//  Movie Forecast
//
//  Created by Josue on 02/03/24.
//

import Foundation
import FirebaseAuth


struct AuthDataResultModel {
    let uid: String
    let email: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
    }
}

final class AuthenticationManager{
    static let shared = AuthenticationManager()
    private init(){}
}

extension AuthenticationManager {
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        try await UserManager.shared.createUser(user: AuthDataResultModel(user: authDataResult.user))
        return AuthDataResultModel(user: authDataResult.user)
    }
}
