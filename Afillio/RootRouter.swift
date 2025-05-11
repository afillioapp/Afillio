//  RootRouter.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

import SwiftUI

/// Routes the user to the correct screen based on auth state.
struct RootRouter: View {
    @EnvironmentObject private var session: SessionManager

    var body: some View {
        Group {
            switch session.authState {
            case .loading:
                ProgressView("Loading…")

            case .unauthenticated:
                AuthenticationView()

            case .authenticated(let role):
                switch role {
                case .brand:      BrandDashboardView()
                case .influencer: InfluencerDashboardView()
                case .admin:      AdminDashboardView()
                }
            }
        }
        .onAppear { session.listen() }
    }
}
