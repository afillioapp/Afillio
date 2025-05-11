// MARK: ────────────────────────────────────────────────
//  Campaign.swift
// ──────────────────────────────────────────────────────
import FirebaseFirestore           // ← was FirebaseFirestoreSwift


struct Campaign: Identifiable, Codable {
    @DocumentID var id: String?
    var brandID: String
    var title: String
    var description: String
    var budget: Double
    var spent: Double = 0
    var durationDays: Int
    var targetAudience: String
    var status: String = "pending" // pending, open, closed
    var createdAt: Date = Date()
}
