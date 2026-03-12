//
//  PhoneShell.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//

import SwiftUI

// ─── MARK: Phone Shell ────────────────────────────────────────────────────────
// Wraps any screen content in the iPhone 16 hardware frame.

struct PhoneShell<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .frame(width: 393, height: 852)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 54))
        .overlay(
            RoundedRectangle(cornerRadius: 54)
                .stroke(Color(hex: "#b0b0b5"), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.38), radius: 40, x: 0, y: 30)
    }
}

// ─── MARK: Preview ────────────────────────────────────────────────────────────

#Preview("Phone Shell") {
    PhoneShell {
        Text("Hello, World!")
            .font(.largeTitle)
    }
}