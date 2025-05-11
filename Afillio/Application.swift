//
//   Application.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

// MARK: ────────────────────────────────────────────────
//  Application.swift
// ──────────────────────────────────────────────────────
import FirebaseFirestore           // ← update here

struct Application: Identifiable, Codable {
    @DocumentID var id: String?
    var campaignID: String
    var influencerID: String
    var message: String
    var status: Status
    var createdAt: Date = Date()

    enum Status: String, Codable { case pending, accepted, rejected }
}
