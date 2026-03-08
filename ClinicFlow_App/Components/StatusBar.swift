//
//  StatusBar.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//

import SwiftUI

struct CFStatusBar: View {
    var body: some View {
        ZStack {
            Color.white

            // Dynamic Island pill
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black)
                .frame(width: 120, height: 34)
                .offset(y: -6)

            HStack {
                // Time
                Text("9:41")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.cfText)
                    .kerning(-0.3)

                Spacer()

                // Carrier / connectivity / battery
                HStack(spacing: 5) {
                    Image(systemName: "cellularbars")
                        .font(.system(size: 13, weight: .medium))
                    Image(systemName: "wifi")
                        .font(.system(size: 13, weight: .medium))
                    Image(systemName: "battery.75")
                        .font(.system(size: 13, weight: .medium))
                }
                .foregroundColor(.cfText)
            }
            .padding(.horizontal, 28)
            .padding(.top, 14)
        }
        .frame(height: 59)
    }
}

// ── Preview ────────────────────────────────────────────────────────────────────

#Preview {
    CFStatusBar()
        .frame(width: 393)
}
