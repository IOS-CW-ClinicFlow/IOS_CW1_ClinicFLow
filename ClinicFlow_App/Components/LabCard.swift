//
//  LabCard.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct LabCard: View {
    let lab: Lab
    var action: (() -> Void)? = nil

    var body: some View {
        Button { action?() } label: {
            VStack(spacing: 0) {

                // ── Photo ──────────────────────────────────────────────────
                ZStack(alignment: .bottomTrailing) {
                    Image(lab.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 92)
                        .clipped()

                    RatingBadge(rating: lab.rating)
                        .padding(8)
                }
                .frame(height: 92)

                // ── Info ───────────────────────────────────────────────────
                VStack(alignment: .leading, spacing: 5) {
                    Text(lab.name)
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(.cfText)

                    HStack(spacing: 5) {
                        Circle()
                            .fill(Color.cfBlue)
                            .frame(width: 7, height: 7)
                        Text("\(lab.waitTime) · \(lab.distance)")
                            .font(.system(size: 11))
                            .foregroundColor(.cfSubtext)
                    }
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
    LabCard(lab: HomeData.labs[0])
        .frame(width: 180)
        .padding()
}
