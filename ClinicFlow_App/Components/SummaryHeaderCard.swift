//
//  SummaryHeaderCard.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import SwiftUI

struct SummaryHeaderCard: View {
    let context: BookingContext

    var body: some View {
        HStack(spacing: 14) {
            avatarView
            infoView
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color(hex: "#F8FBFF"))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color(hex: "#E8F0FB"), lineWidth: 1)
        )
    }

    // ── Avatar ────────────────────────────────────────────────────────────

    @ViewBuilder
    private var avatarView: some View {
        switch context {
        case .doctor(let detail):
            ZStack(alignment: .bottomTrailing) {
                Image(detail.avatarName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 66, height: 66)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(hex: "#D6E8F8"), lineWidth: 3))

                // Verified badge
                ZStack {
                    Circle()
                        .fill(Color(hex: "#2196F3"))
                        .frame(width: 20, height: 20)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    Image(systemName: "checkmark")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(.white)
                }
                .offset(x: 2, y: 2)
            }

        case .lab:
            ZStack {
                Circle()
                    .fill(Color(hex: "#E8F0FB"))
                    .frame(width: 66, height: 66)
                Image(systemName: "cross.vial.fill")
                    .font(.system(size: 26))
                    .foregroundStyle(Color(hex: "#2196F3"))
            }
        }
    }

    // ── Info ──────────────────────────────────────────────────────────────

    @ViewBuilder
    private var infoView: some View {
        switch context {
        case .doctor(let detail):
            VStack(alignment: .leading, spacing: 4) {
                Text(detail.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color(hex: "#1a1a1a"))
                Text(detail.specialty)
                    .font(.system(size: 13))
                    .foregroundStyle(Color(hex: "#888888"))
            }

        case .lab(let labName, _):
            VStack(alignment: .leading, spacing: 4) {
                Text(labName)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color(hex: "#1a1a1a"))
                Text("Lab Test")
                    .font(.system(size: 13))
                    .foregroundStyle(Color(hex: "#888888"))
            }
        }
    }
}
