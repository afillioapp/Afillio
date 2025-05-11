//
//   AuthenticationViewModel.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class AuthenticationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var phone = ""
    @Published var selectedRole: UserRole = .brand
    @Published var isNewUser = false
    @Published var errorMessage: String?

    func submit() async {
        do {
            if isNewUser {
                try await register()
            } else {
                try await login()
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func login() async throws {
        if !email.isEmpty {
            try await Auth.auth().signIn(withEmail: email, password: password)
        } else {
            // quick phone auth example (real app should use verification ID flow)
            try await Auth.auth().signIn(withCustomToken: phone)
        }
    }

    private func register() async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        try await Firestore.firestore()
            .collection("users")
            .document(result.user.uid)
            .setData([
                "role": selectedRole.rawValue,
                "createdAt": FieldValue.serverTimestamp(),
                "email": email,
                "phone": phone
            ])
        try await result.user.sendEmailVerification()
    }
}
