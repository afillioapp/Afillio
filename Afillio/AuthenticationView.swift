//
//  AuthenticationView.swift
//  Afillio
//
//  Updated: Modern gradient branding – 2025-05-11
//

import SwiftUI

// MARK: - Brand Palette
private extension Color {
    static let brandGreen = Color(hex: "#D7E157")
    static let brandBlue  = Color(hex: "#84C6EA")
    static let brandBlack = Color(hex: "#231F20")
}

// MARK: - Gradient Background (animated)
private struct AnimatedGradient: View {
    @State private var angle: Double = 0
    var body: some View {
        AngularGradient(
            colors: [.brandBlue, .brandGreen, .brandBlue],
            center: .center,
            angle: .degrees(angle)
        )
        .animation(.linear(duration: 20).repeatForever(autoreverses: false), value: angle)
        .onAppear { angle = 360 }
        .ignoresSafeArea()
    }
}

// MARK: - Authentication Screen
struct AuthenticationView: View {
    @StateObject private var vm = AuthenticationViewModel()
    @State private var buttonPressed = false

    var body: some View {
        ZStack {
            AnimatedGradient()                        // ⬅️ full-screen background

            ScrollView {                              // for smaller devices
                VStack(spacing: 28) {
                    Spacer(minLength: 60)

                    // ─── Logo ───
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .shadow(color: .black.opacity(0.25), radius: 10, y: 4)

                    // ─── Frosted Card ───
                    VStack(spacing: 20) {
                        // Role picker
                        Picker("Role", selection: $vm.selectedRole) {
                            ForEach(UserRole.allCases, id: \.self) { role in
                                Text(role.rawValue.capitalized)
                            }
                        }
                        .pickerStyle(.segmented)
                        .tint(.brandBlue)

                        // Email / Password
                        Group {
                            TextField("Email", text: $vm.email)
                                .keyboardType(.emailAddress)
                                .textContentType(.emailAddress)
                                .autocapitalization(.none)

                            SecureField("Password", text: $vm.password)
                        }
                        .textFieldStyle(.roundedBorder)

                        // New-user toggle
                        Toggle("New User?", isOn: $vm.isNewUser)
                            .toggleStyle(SwitchToggleStyle(tint: .brandGreen.opacity(0.9)))

                        // CTA button
                        Button(action: {
                            buttonPressed = true
                            Task { await vm.submit(); buttonPressed = false }
                        }) {
                            Text(vm.isNewUser ? "Sign Up" : "Log In")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    Capsule()
                                        .fill(LinearGradient(
                                            colors: [.brandGreen, .brandBlue],
                                            startPoint: .leading,
                                            endPoint: .trailing))
                                )
                                .scaleEffect(buttonPressed ? 0.96 : 1)
                                .animation(.easeOut(duration: 0.15), value: buttonPressed)
                                .foregroundColor(.brandBlack)
                        }
                        .buttonStyle(.plain)

                        // Error message
                        if let error = vm.errorMessage {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(28)
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
                    .shadow(color: .black.opacity(0.15), radius: 20, y: 5)
                    .padding(.horizontal, 24)

                    Spacer(minLength: 80)
                }
            }
        }
    }
}

