//
//  DoctorCard.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct DoctorCard: View {
    let doctor: Doctor
    var action: (() -> Void)? = nil

    var body: some View {
        Button { action?() } label: {
            VStack(spacing: 0) {

                // ── Photo ──────────────────────────────────────────────────
                ZStack(alignment: .bottomTrailing) {
                    Image(doctor.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 110)
                        .clipped()
                        .background(Color(hex: doctor.backgroundColorHex))

                    RatingBadge(rating: doctor.rating)
                        .padding(8)
                }
                .frame(height: 110)

                // ── Info ───────────────────────────────────────────────────
                VStack(alignment: .leading, spacing: 3) {
                    Text(doctor.name)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.cfText)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(doctor.credentials)
                        .font(.system(size: 10))
                        .foregroundColor(.cfSubtext)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.vertical, 9)
            }
            .background(HomeTheme.cardBg)
            .clipShape(RoundedRectangle(cornerRadius: HomeTheme.cardCornerRadius))
            .shadow(color: HomeTheme.cardShadow,
                    radius: HomeTheme.cardShadowRadius, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    DoctorCard(doctor: HomeData.doctors[0])
        .frame(width: 180)
        .padding()
}
