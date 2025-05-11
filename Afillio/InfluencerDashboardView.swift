//
//  InfluencerDashboardView.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

import SwiftUI

struct InfluencerDashboardView: View {
    @EnvironmentObject private var session: SessionManager
    @StateObject private var vm = InfluencerDashboardViewModel()
    @State private var message = ""

    var body: some View {
        NavigationStack {
            List {
                Section("Open Campaigns") {
                    ForEach(vm.openCampaigns) { c in
                        VStack(alignment: .leading) {
                            Text(c.title).bold()
                            Button("Apply") {
                                Task {
                                    try await vm.apply(to: c, message: "Hi! I'd love to collaborate.")
                                }
                            }
                        }
                    }
                }
                Section("My Applications") {
                    ForEach(vm.myApplications) { app in
                        Text("\(app.campaignID) – \(app.status.rawValue.capitalized)")
                    }
                }
            }
            .navigationTitle("Influencer")
            .toolbar { ToolbarItem(placement: .navigationBarLeading) {
                Button("Sign Out") { session.signOut() }
            }}
        }
    }
}
