//
//  LabHeroView.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import SwiftUI

struct LabHeroView: View {
    let imageName:   String
    var isFavourited: Bool = true
    var onBack:       () -> Void = {}
    var onShare:      () -> Void = {}
    var onFavourite:  () -> Void = {}

    var body: some View {
        ZStack(alignment: .bottom) {

            // Hero image
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 220)
                .clipped()

            // Gradient overlay
            LinearGradient(
                colors: [Color.black.opacity(0.45), Color.black.opacity(0.05), Color.clear],
                startPoint: .top,
                endPoint: .bottom
            )

            // Back / Share / Heart buttons
            HStack {
                circleButton(systemName: "chevron.left", bg: Color.white.opacity(0.9),
                             fg: Color(hex: "#444444"), action: onBack)
                Spacer()
                HStack(spacing: 8) {
                    circleButton(systemName: "square.and.arrow.up", bg: Color.white.opacity(0.9),
                                 fg: Color(hex: "#444444"), action: onShare)
                    circleButton(systemName: isFavourited ? "heart.fill" : "heart",
                                 bg: isFavourited ? Color(hex: "#E53935") : Color.white.opacity(0.9),
                                 fg: isFavourited ? .white : Color(hex: "#444444"),
                                 action: onFavourite)
                }
            }
            .padding(.horizontal, 14)
            .padding(.bottom, 16)
        }
        .frame(height: 220)
    }

    @ViewBuilder
    private func circleButton(
        systemName: String,
        bg: Color,
        fg: Color,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(bg)
                    .frame(width: 36, height: 36)
                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 2)
                Image(systemName: systemName)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(fg)
            }
        }
        .buttonStyle(.plain)
    }
}
