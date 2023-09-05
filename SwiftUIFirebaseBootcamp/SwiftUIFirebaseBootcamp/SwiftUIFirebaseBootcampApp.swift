//
//  SwiftUIFirebaseBootcampApp.swift
//  SwiftUIFirebaseBootcamp
//
//  Created by Manish Parihar on 05.09.23.
//

import SwiftUI
import FirebaseCore

@main
struct SwiftUIFirebaseBootcampApp: App {
    
    // register app delegate for Firebase setup
     @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    // Type of way to call Fire base - Type 1
    /*
    init() {
        FirebaseApp.configure()
        print("Configured Firebase!")
    }
    */
    
    var body: some Scene {
        WindowGroup {
                RootView()
        }
    }
}

// Type of way to call Fire base - Type 2
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
    FirebaseApp.configure()
    // print("Configured Firebase!")
      
    return true
  }
}
