//
//  NotificationCaard.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-09.
//
import SwiftUI

struct NotificationCard: View {
    let notif: AppNotification

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            // ── Yellow bell icon ───────────────────────────────────────────
            ZStack {
                Circle()
                    .fill(Color(hex: "#FFF8E1"))
                    .frame(width: 42, height: 42)
                Image(systemName: "bell.fill")
                    .font(.system(size: 18))
                    .foregroundColor(Color(hex: "#FFA000"))
            }

            // ── Date + message ─────────────────────────────────────────────
            VStack(alignment: .leading, spacing: 4) {
                Text("\(notif.date) | \(notif.time)")
                    .font(.system(size: 12))
                    .foregroundColor(Color(hex: "#999999"))
                Text(notif.message)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color(hex: "#1a1a1a"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // ── Time ago ───────────────────────────────────────────────────
            Text(notif.ago)
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(Color(hex: "#2196F3"))
                .padding(.top, 2)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 13)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 2)
    }
}

#Preview {
    NotificationCard(notif: NotificationsData.notifications[0])
        .padding()
}
