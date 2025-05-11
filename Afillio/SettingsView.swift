//
//  SettingsView.swift
//  Afillio
//
//  Created by Alireza Motahari on 2025-05-10.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var session: SessionManager
    @StateObject private var vm = SettingsViewModel()
    
    var body: some View {
        Form {
            // Display name
            TextField("Display Name", text: $vm.profile.displayName)
            
            // Bio (optional)
            TextField("Bio", text: $vm.profile.bio.withDefault(""))
            
            Button("Save") {
                Task { await vm.save() }
            }
            .buttonStyle(.borderedProminent)
            
            Button("Delete Account", role: .destructive) {
                Task {
                    await vm.deleteAccount()
                    session.signOut()
                }
            }
        }
        .navigationTitle("Settings")
        .alert("Error",
               isPresented: .constant(vm.errorMessage != nil),
               actions: { Button("OK") { vm.errorMessage = nil } },
               message: { Text(vm.errorMessage ?? "") })
    }
}
