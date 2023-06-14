//
//  swift_firebase_starterApp.swift
//  swift-firebase-starter
//
//  Created by vonweniger on 14.06.23.
//

@main
struct swift_firebase_starterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
        }
    }
}
