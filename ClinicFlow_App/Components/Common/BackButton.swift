//
//  BackButton.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
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
