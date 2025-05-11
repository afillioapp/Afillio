//
//  SessionManager.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

// ──────────────────────────────────────────────────────
import Combine
import FirebaseAuth
import FirebaseFirestore

enum UserRole: String, Codable, CaseIterable {
    case brand, influencer, admin
}

final class SessionManager: ObservableObject {
    enum AuthState {
        case loading
        case unauthenticated
        case authenticated(UserRole)
    }

    @Published private(set) var authState: AuthState = .loading
    @Published private(set) var userID: String?

    private var listener: AuthStateDidChangeListenerHandle?
    private let db = Firestore.firestore()

    func listen() {
        listener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            if let user = user {
                self.userID = user.uid
                self.fetchRole(for: user.uid)
            } else {
                self.authState = .unauthenticated
                self.userID = nil
            }
        }
    }

    private func fetchRole(for uid: String) {
        db.collection("users").document(uid).getDocument { [weak self] snap, error in
            guard let self = self else { return }
            if let data = snap?.data(), let raw = data["role"] as? String, let role = UserRole(rawValue: raw) {
                self.authState = .authenticated(role)
            } else {
                self.authState = .unauthenticated
            }
        }
    }

    func signOut() {
        try? Auth.auth().signOut()
        authState = .unauthenticated
    }

    deinit { if let l = listener { Auth.auth().removeStateDidChangeListener(l) } }
}
