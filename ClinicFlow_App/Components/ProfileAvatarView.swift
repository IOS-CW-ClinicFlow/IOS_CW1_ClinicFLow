//
//  ProfileAvatarView.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-10.
//
import SwiftUI

struct ProfileAvatarView: View {
    let name: String
    let avatarName: String
    var onEditTap: () -> Void = {}

    var body: some View {
        VStack(spacing: 14) {

            // ── Avatar with edit badge ─────────────────────────────────────
            ZStack(alignment: .bottomTrailing) {
                Image(avatarName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(hex: "#E0ECF8"), lineWidth: 3))

                // Blue edit badge
                Button { onEditTap() } label: {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#2196F3"))
                            .frame(width: 28, height: 28)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2.5))
                        Image(systemName: "pencil")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .buttonStyle(.plain)
                .offset(x: 2, y: 2)
            }

            // ── Name ───────────────────────────────────────────────────────
            Text(name)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(Color(hex: "#1a1a1a"))
                .kerning(-0.3)
        }
        .padding(.top, 10)
        .padding(.bottom, 28)
    }
}

#Preview {
    ProfileAvatarView(name: "Saleh Sameer", avatarName: "profile_avatar")
}
