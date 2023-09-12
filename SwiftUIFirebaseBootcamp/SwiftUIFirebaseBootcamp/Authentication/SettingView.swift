//
//  SettingView.swift
//  SwiftUIFirebaseBootcamp
//
//  Created by Manish Parihar on 05.09.23.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut() throws {
       try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else{
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "123@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    
    func updatePassword() async throws {
        let password = "123456"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
}

struct SettingView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Log out"){
                Task{
                    do {
                        try  viewModel.signOut()
                        showSignInView = true
                    }catch {
                        print(error)
                    }
                }
            }
            emailSections
        }.navigationTitle("Settings")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingView(showSignInView: .constant(false))
        }
    }
}

extension SettingView {
    
    private var emailSections:some View {
        Section {
            
            Button("Reset password"){
                Task{
                    do {
                        try  await viewModel.resetPassword()
                        print("Password RESET")
                    }catch {
                        print(error)
                    }
                }
            }
            
            Button("Update password"){
                Task{
                    do {
                        try  await viewModel.updatePassword()
                        print("Password Updated")
                    }catch {
                        print(error)
                    }
                }
            }
            
            Button("Update email"){
                Task{
                    do {
                        try  await viewModel.updatePassword()
                        print("Email Updated")
                    }catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Email funtions")
        }
    }
}
