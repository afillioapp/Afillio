//
//  CampaignEditor.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

import SwiftUI

struct CampaignEditor: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var session: SessionManager

    @State private var title = ""
    @State private var desc = ""
    @State private var budget = ""
    @State private var duration = ""
    @State private var audience = ""

    let onSave: (Campaign) -> Void

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $desc, axis: .vertical)
                TextField("Budget", text: $budget)
                    .keyboardType(.decimalPad)
                TextField("Duration (days)", text: $duration)
                    .keyboardType(.numberPad)
                TextField("Target Audience", text: $audience)
            }
            .navigationTitle("New Campaign")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard
                            let b = Double(budget),
                            let d = Int(duration),
                            let uid = session.userID else { return }
                        onSave(Campaign(
                            brandID: uid,
                            title: title,
                            description: desc,
                            budget: b,
                            durationDays: d,
                            targetAudience: audience
                        ))
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
