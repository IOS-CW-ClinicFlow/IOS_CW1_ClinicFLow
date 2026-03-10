//
//  ProfileScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-10.
//
import SwiftUI

struct ProfileScreen: View {

    var onBack:   () -> Void = {}
    var onLogout: () -> Void = {}

    @State private var showLogoutConfirmation = false

    var body: some View {
        VStack(spacing: 0) {

            // ── Fixed top bar ──────────────────────────────────────────────
            TopBar(title: "Profile", showBack: true, onBack: onBack)

            // ── Scrollable body ────────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // ── Avatar + name ──────────────────────────────────────
                    ProfileAvatarView(
                        name:       ProfileData.userName,
                        avatarName: ProfileData.avatarName
                    )

                    // ── Menu list ──────────────────────────────────────────
                    VStack(spacing: 0) {
                        ForEach(Array(ProfileData.menuItems.enumerated()), id: \.element.id) { index, item in
                            ProfileMenuRow(
                                item:  item,
                                onTap: item.label == "Log out" ? { showLogoutConfirmation = true } : {}
                            )

                            // Divider between rows (not after last)
                            if index < ProfileData.menuItems.count - 1 {
                                Rectangle()
                                    .fill(Color(hex: "#F0F0F5"))
                                    .frame(height: 1)
                                    .padding(.horizontal, 22)
                            }
                        }
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.06), radius: 12, x: 0, y: 2)
                    .padding(.horizontal, 18)
                    .padding(.bottom, 24)
                }
            }
            .background(Color(hex: "#F4F6FB"))
        }
        .background(Color(hex: "#F4F6FB"))
        .confirmDialog(
            title:        "Log out",
            message:      "Are you sure you want to log out?",
            confirmLabel: "Log out",
            isPresented:  $showLogoutConfirmation,
            onConfirm:    onLogout
        )
    }
}

#Preview {
    ProfileScreen()
}
