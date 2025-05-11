//  AfillioApp.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

import SwiftUI
import FirebaseCore

@main
struct AfillioApp: App {
    // Bootstrap Firebase and inject SessionManager into the environment
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var session = SessionManager()

    var body: some Scene {
        WindowGroup {
            RootRouter()
                .environmentObject(session)
        }
    }
}

/// Handles app-level services (Firebase, Stripe, etc.)
final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        StripeManager.shared.configure()          // see StripeManager.swift
        return true
    }
}
