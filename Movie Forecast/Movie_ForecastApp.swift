//
//  Movie_ForecastApp.swift
//  Movie Forecast
//
//  Created by Josue on 10/02/24.
//

import SwiftUI
import Firebase

@main
struct Movie_ForecastApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//    init(){
//        FirebaseApp.configure()
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

/* FIRE BASE CODE
 
 import SwiftUI
 import FirebaseCore


 class AppDelegate: NSObject, UIApplicationDelegate {
   func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
     FirebaseApp.configure()

     return true
   }
 }

 @main
 struct YourApp: App {
   // register app delegate for Firebase setup
   @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


   var body: some Scene {
     WindowGroup {
       NavigationView {
         ContentView()
       }
     }
   }
 }
 
 */
