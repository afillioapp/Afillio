//
//  Untitled.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

import FirebaseFirestore           // ← update here


struct UserProfile: Identifiable, Codable {
    @DocumentID var id: String?
    var role: UserRole
    var displayName: String
    var approved: Bool
    var bio: String?
}
