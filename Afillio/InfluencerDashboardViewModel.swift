//
//  InfluencerDashboardViewModel.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor
final class InfluencerDashboardViewModel: ObservableObject {
    @Published var openCampaigns: [Campaign] = []
    @Published var myApplications: [Application] = []
    private let db = Firestore.firestore()
    private let uid: String

    init(uid: String = Auth.auth().currentUser?.uid ?? "") {
        self.uid = uid
        Task {
            await fetchOpen()
            await fetchMine()
        }
    }

    func fetchOpen() async {
        let snap = try? await db.collection("campaigns")
            .whereField("status", isEqualTo: "open").getDocuments()
        openCampaigns = snap?.documents.compactMap { try? $0.data(as: Campaign.self) } ?? []
    }

    func fetchMine() async {
        let snap = try? await db.collection("applications")
            .whereField("influencerID", isEqualTo: uid).getDocuments()
        myApplications = snap?.documents.compactMap { try? $0.data(as: Application.self) } ?? []
    }

    func apply(to campaign: Campaign, message: String) async throws {
        let app = Application(campaignID: campaign.id!,
                              influencerID: uid,
                              message: message,
                              status: .pending)
        _ = try await db.collection("applications").addDocument(from: app)
        await fetchMine()
    }
}
