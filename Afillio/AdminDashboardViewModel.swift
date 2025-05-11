//
//  AdminDashboardViewModel.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

import Foundation
import FirebaseFirestore

@MainActor
final class AdminDashboardViewModel: ObservableObject {
    @Published var pendingInfluencers: [UserProfile] = []
    @Published var pendingCampaigns: [Campaign] = []

    private let db = Firestore.firestore()

    init() {
        Task { await refresh() }
    }

    func refresh() async {
        let uSnap = try? await db.collection("users")
            .whereField("approved", isEqualTo: false).getDocuments()
        pendingInfluencers = uSnap?.documents.compactMap { try? $0.data(as: UserProfile.self) } ?? []

        let cSnap = try? await db.collection("campaigns")
            .whereField("status", isEqualTo: "pending").getDocuments()
        pendingCampaigns = cSnap?.documents.compactMap { try? $0.data(as: Campaign.self) } ?? []
    }

    func approveInfluencer(_ profile: UserProfile) async throws {
        try await db.collection("users").document(profile.id!).updateData(["approved": true])
        await refresh()
    }

    func approveCampaign(_ campaign: Campaign) async throws {
        try await db.collection("campaigns").document(campaign.id!).updateData(["status": "open"])
        await refresh()
    }
}
