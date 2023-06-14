//
//  SettingsViewModel.swift
//  AskAiden
//
//  Created by vonweniger on 13.06.23.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    @Published var authProviders: [AuthProviderOption] = []
    
    func loadAuthProviders() {
        if let providers = try? AuthManager.shared.getProviders() {
            authProviders = providers
        }
    }
    
    func logOut() throws {
        try AuthManager.shared.signOut()
    }
    
    func deleteAccount() async throws {
        try await AuthManager.shared.deleteUser()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthManager.shared.getAuthUser()
        
        //TODO: ADD CUSTOM ERROR HANDLER
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthManager.shared.resetPassword(email: email)
    }
    
    
    //TODO: add email update input field
    func updateEmail() async throws {
        let email = "askaiden.ai@gmail.com"
        try await AuthManager.shared.updateEmail(email: email)
    }
    
    //TODO: add password update input field
    func updatePassword() async throws {
        let password = "demo"
        try await AuthManager.shared.updatePassword(password: password)
    }
}
