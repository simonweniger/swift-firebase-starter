//
//  SettingsView.swift
//  AskAiden
//
//  Created by vonweniger on 11.06.23.
//

//TODO: add re-authentification screen if the user hasn't recently logged in

import SwiftUI



//TODO: ADD ERROR HANDELING TO SIGNOUT CATCH
struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List{
            Button("Log out") {
                do {
                    try viewModel.logOut()
                    showSignInView = true
                } catch {
                    print(error)
                }
            }
            
            //TODO: ADD CONFIRMATION MODAL & ADD RE AUTH AFTER CONFIRMATION 
            Button(role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteAccount()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Delete account")
            }
            
            if viewModel.authProviders.contains(.email) {
                emailSection
            }
            
        }
        .onAppear {
            viewModel.loadAuthProviders()
        }
        .navigationBarTitle("Settigns")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(showSignInView: .constant(false))
        }
    }
}

extension SettingsView {
    
    private var emailSection: some View {
        Section {
            Button("Reset Passwod") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password Reset")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update Passwod") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("Password Reset")
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button("Update Email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("Email Updated")
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Email Settings")
        }
    }
}
