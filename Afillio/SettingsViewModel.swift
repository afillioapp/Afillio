//
//  SettingsViewModel.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class SettingsViewModel: ObservableObject {
    // MARK: - Published state
    @Published var profile = UserProfile(role: .brand, displayName: "", approved: true)
    @Published var errorMessage: String?

    // MARK: - Private
    private let db  = Firestore.firestore()
    private let uid = Auth.auth().currentUser?.uid ?? ""

    // MARK: - Init
    init() { Task { await fetch() } }

    // MARK: - CRUD
    func fetch() async {
        do {
            let doc = try await db.collection("users").document(uid).getDocument()
            if let decoded = try? doc.data(as: UserProfile.self) {
                profile = decoded
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func save() async {
        do {
            try await db.collection("users")
                .document(uid)
                .setData(from: profile)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func deleteAccount() async {
        do {
            try await db.collection("users").document(uid).delete()
            try await Auth.auth().currentUser?.delete()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
