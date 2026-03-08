//
//  BackButton.swift
//  ClinicFlow_App
//
//  A reusable back button used across authentication screens.
//  Wraps the `BackArrowIcon` inside a plain-styled button with
//  consistent padding and hit area.
//

import SwiftUI

struct BackButton: View {
    /// Closure fired when the button is tapped.
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            BackArrowIcon()
        }
        .buttonStyle(.plain)
        .padding(.top, 8)
        .padding(.bottom, 28)
    }
}

// ── Preview ───────────────────────────────────────────────────────────────────

#Preview("Back Button") {
    BackButton(action: {})
}