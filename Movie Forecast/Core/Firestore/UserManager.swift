//
//  UserManager.swift
//  Movie Forecast
//
//  Created by Josue on 20/02/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth


final class UserManager{
    
    static let shared = UserManager()
    private init() {}
    
    
    //create new user from user id created in firebase authentication method
    func createUser(user: AuthDataResultModel) async throws {
        var userData: [String:Any] = [
            "userId": user.uid,
            "date_created" : Timestamp(),
        ]
        if let email = user.email{
            userData["userEmail"] = email
        }
        
        //trys to create user in users collection with user id and created datestamp
        try await Firestore.firestore().collection("users").document(user.uid).setData(userData, merge: false)
    }
    
//    //Get the information from database collection of user that logged in
//    func getUser(userId: String) async throws -> String{
//        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
//        
//        guard let data = snapshot.data() else{
//            throw URLError(.badServerResponse)
//        }
//        
//        let userId = data["userId"] as? String
////        let email 
//    }
}
