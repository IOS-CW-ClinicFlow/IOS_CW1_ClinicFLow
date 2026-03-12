//
//  ProfileMenuRow.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-10.
//
import SwiftUI

struct ProfileMenuRow: View {
    let item: ProfileMenuItem
    var onTap: () -> Void = {}

    var body: some View {
        Button { onTap() } label: {
            HStack(spacing: 18) {

                // ── Icon ───────────────────────────────────────────────────
                ZStack {
                    Circle()
                        .fill(Color(hex: "#EAF4FE"))
                        .frame(width: 40, height: 40)
                    Image(systemName: item.icon)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(Color(hex: "#1A8FD1"))
                }

                // ── Label ──────────────────────────────────────────────────
                Text(item.label)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(item.isDestructive ? Color(hex: "#F44336") : Color(hex: "#1a1a1a"))

                Spacer()

                // ── Chevron ────────────────────────────────────────────────
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color(hex: "#C8C8D0"))
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 14)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 0) {
        ProfileMenuRow(item: ProfileMenuItem(label: "Your profile", icon: "person"))
        Divider().padding(.horizontal, 22)
        ProfileMenuRow(item: ProfileMenuItem(label: "Log out", icon: "rectangle.portrait.and.arrow.right", isDestructive: true))
    }
}
