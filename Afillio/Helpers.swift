//
//  Helpers.swift
//  Afillio
//
//  Do NOT edit – keep exactly as is.
//

import SwiftUI

extension Binding where Value == String? {
    func withDefault(_ defaultValue: String) -> Binding<String> {
        Binding<String>(
            get: { self.wrappedValue ?? defaultValue },
            set: { self.wrappedValue = $0.isEmpty ? nil : $0 }
        )
    }
}


// MARK: - Hex → Color helper (place once in project)
extension Color {
    /// Initialize `Color` with a hex string like "#FFFFFF" or "FFFFFF".
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacing("#", with: "")
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8)  & 0xFF) / 255
        let b = Double((int >> 0)  & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
