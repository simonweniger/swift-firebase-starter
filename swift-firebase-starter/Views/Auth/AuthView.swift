//
//  AuthView.swift
//  AskAiden
//
//  Created by vonweniger on 09.06.23.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

struct AuthView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            Spacer()
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text ("Sign In With Email")
                .font (.headline)
                .foregroundColor (.white)
                .frame (height: 55)
                .frame (maxWidth: .infinity)
                .background (Color.blue)
                .cornerRadius (10)
            }
            
            //TODO: REPLACE WITH CUSTOM BUTTON
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel (scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    do {
                        try await viewModel.signInGoogle()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            }
            
            Button(action: {
                Task {
                    do {
                        try await viewModel.signInApple()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            }, label: {
                SignInWithAppleButtonViewRepresentable(type: .default, style: .black)
                    .allowsHitTesting(false)
            })
            .frame(height: 55)
            
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthView(showSignInView: .constant(false))
        }
    }
}
