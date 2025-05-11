//
//  BrandDashboardViewModel.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

// MARK: ────────────────────────────────────────────────
//  BrandDashboardViewModel.swift
//  CRUD campaigns + performance
// ──────────────────────────────────────────────────────
import Foundation
import FirebaseFirestore
import FirebaseAuth


@MainActor
final class BrandDashboardViewModel: ObservableObject {
    @Published var campaigns: [Campaign] = []
    @Published var showCreateSheet = false
    private let db = Firestore.firestore()
    private let uid: String

    init(uid: String = Auth.auth().currentUser?.uid ?? "") {
        self.uid = uid
        Task { await fetchCampaigns() }
    }

    func fetchCampaigns() async {
        let snap = try? await db.collection("campaigns")
            .whereField("brandID", isEqualTo: uid).getDocuments()
        campaigns = snap?.documents.compactMap { try? $0.data(as: Campaign.self) } ?? []
    }

    func create(_ c: Campaign) async throws {
        _ = try await db.collection("campaigns").addDocument(from: c)
        await fetchCampaigns()
    }
}
