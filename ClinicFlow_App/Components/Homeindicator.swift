//
//  Homeindicator.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct CFHomeIndicator: View {
    var body: some View {
        ZStack {
            Color.white
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.black.opacity(0.18))
                .frame(width: 134, height: 5)
        }
        .frame(height: 34)
    }
}

// ── Preview ────────────────────────────────────────────────────────────────────

#Preview {
    CFHomeIndicator()
        .frame(width: 393)
}
