//
//   BrandDashboardView.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

// MARK: ────────────────────────────────────────────────
//  BrandDashboardView.swift
// ──────────────────────────────────────────────────────
import SwiftUI

struct BrandDashboardView: View {
    @EnvironmentObject private var session: SessionManager
    @StateObject private var vm = BrandDashboardViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.campaigns) { CampaignRow(campaign: $0) }
            }
            .navigationTitle("Your Campaigns")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Sign Out") { session.signOut() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { vm.showCreateSheet = true } label: { Image(systemName: "plus") }
                }
            }
            .sheet(isPresented: $vm.showCreateSheet) {
                CampaignEditor(onSave: { c in Task { try await vm.create(c) } })
            }
        }
    }
}

struct CampaignRow: View {
    let campaign: Campaign
    var body: some View {
        VStack(alignment: .leading) {
            Text(campaign.title).font(.headline)
            Text("Budget: $\(campaign.budget, specifier: "%.2f")")
            ProgressView(value: campaign.spent / campaign.budget)
        }
    }
}
