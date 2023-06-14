//
//  SignInEmailViewModel.swift
//  AskAiden
//
//  Created by vonweniger on 13.06.23.
//

import Foundation

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        //ToDo: Add propper validation
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        let authDataResult = try await AuthManager.shared.createUser(email: email, password: password )
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    func signIn() async throws {
        //ToDo: Add propper validation
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        try await AuthManager.shared.signInUser(email: email, password: password )
    }
    
}
