//
//  RatingBadge.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct RatingBadge: View {
    let rating: Double

    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: "star.fill")
                .font(.system(size: 9))
                .foregroundColor(HomeTheme.ratingStarColor)
            Text(String(format: "%.1f", rating))
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(HomeTheme.ratingTextColor)
        }
        .padding(.vertical, 3)
        .padding(.horizontal, 7)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .black.opacity(0.18), radius: 4, x: 0, y: 1)
    }
}

#Preview {
    RatingBadge(rating: 4.7)
        .padding()
}
