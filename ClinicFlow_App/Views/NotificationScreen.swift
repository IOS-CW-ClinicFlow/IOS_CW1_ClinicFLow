//
//  NotificationScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-09.
//
import SwiftUI

struct NotificationsScreen: View {

    var onBack: () -> Void = {}

    @State private var notifications = NotificationsData.notifications

    var body: some View {
        VStack(spacing: 0) {

            // ── Fixed top bar ──────────────────────────────────────────────
            topBar

            // ── Scrollable cards ───────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(notifications) { notif in
                        NotificationCard(notif: notif)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
            }
            .background(Color(hex: "#F4F6FB"))

            // ── Clear All button ───────────────────────────────────────────
            clearAllButton
        }
        .background(Color(hex: "#F4F6FB"))
    }

    // ── Top bar ────────────────────────────────────────────────────────────

    private var topBar: some View {
        TopBar(title: "Notifications", showBack: true, onBack: onBack)
    }

    // ── Clear All ──────────────────────────────────────────────────────────

    private var clearAllButton: some View {
        Button {
            withAnimation { notifications.removeAll() }
        } label: {
            Text("Clear All")
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color(hex: "#2196F3"))
                .clipShape(Capsule())
                .shadow(color: Color(hex: "#2196F3").opacity(0.38), radius: 14, x: 0, y: 4)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 16)
        .background(Color(hex: "#F4F6FB"))
    }
}

#Preview {
    NotificationsScreen()
}
