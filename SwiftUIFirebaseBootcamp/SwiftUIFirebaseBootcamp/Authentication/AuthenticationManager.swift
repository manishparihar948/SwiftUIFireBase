//
//  AuthenticationManager.swift
//  SwiftUIFirebaseBootcamp
//
//  Created by Manish Parihar on 05.09.23.
//

import Foundation
import FirebaseAuth

// Local Data Model
struct AuthDataResultModel {
    let uid:String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    
    // Singleton is not ideal solution for Longer project
    static let shared = AuthenticationManager()
    private init() {
        
    }
    
    // We dont need to authenticate user with async, Because we want immediate search for user.
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    @discardableResult // when you do not want any return from the function
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
       let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
       return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func resetPassword(email:String) async throws {
      try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password:String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.updatePassword(to: password)
    }
    
    func updateEmail(email:String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.updateEmail(to: email)
    }
    
    func signOut() throws {
       try Auth.auth().signOut()
    }
    
}

