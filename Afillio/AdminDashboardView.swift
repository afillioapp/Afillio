//
//  AdminDashboardView.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

import SwiftUI

struct AdminDashboardView: View {
    @EnvironmentObject private var session: SessionManager
    @StateObject private var vm = AdminDashboardViewModel()

    var body: some View {
        NavigationStack {
            List {
                Section("Influencers Awaiting Approval") {
                    ForEach(vm.pendingInfluencers) { p in
                        HStack {
                            Text(p.displayName)
                            Spacer()
                            Button("Approve") { Task { try await vm.approveInfluencer(p) } }
                        }
                    }
                }
                Section("Campaigns Awaiting Approval") {
                    ForEach(vm.pendingCampaigns) { c in
                        HStack {
                            Text(c.title)
                            Spacer()
                            Button("Approve") { Task { try await vm.approveCampaign(c) } }
                        }
                    }
                }
            }
            .navigationTitle("Admin")
            .toolbar { ToolbarItem(placement: .navigationBarLeading) {
                Button("Sign Out") { session.signOut() }
            }}
        }
    }
}
