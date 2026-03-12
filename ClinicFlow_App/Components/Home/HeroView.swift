//
//  HeroView.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-11.
//
import SwiftUI

struct HeroView: View {
    let imageName:    String
    var isFavourited: Bool = false
    var onBack:       () -> Void = {}
    var onShare:      () -> Void = {}
    var onFavourite:  () -> Void = {}

    var body: some View {
        GeometryReader { geo in
            let topInset = geo.safeAreaInsets.top

            ZStack(alignment: .top) {

                // Fallback background
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "#1565C0"), Color(hex: "#42A5F5")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )

                // Hero image
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .clipped()

                // Gradient overlay
                LinearGradient(
                    colors: [Color.black.opacity(0.35), Color.clear],
                    startPoint: .top,
                    endPoint: .center
                )

                // Buttons — positioned just below the safe area (Dynamic Island)
                HStack {
                    Button(action: onBack) {
                        ZStack {
                            Circle()
                                .fill(Color(hex: "#F2F2F7"))
                                .frame(width: 36, height: 36)
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color(hex: "#1a1a1a"))
                        }
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    HStack(spacing: 8) {
                        Button(action: onShare) {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "#F2F2F7"))
                                    .frame(width: 36, height: 36)
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(Color(hex: "#555555"))
                                    .frame(width: 36, height: 36)
                            }
                            
                        }
                        .buttonStyle(.plain)

                        Button(action: onFavourite) {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "#F2F2F7"))
                                    .frame(width: 36, height: 36)
                                Image(systemName: isFavourited ? "heart.fill" : "heart")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(isFavourited ? Color(hex: "#FF5252") : Color(hex: "#555555"))
                                    .frame(width: 36, height: 36)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, topInset + 75)
            }
        }
        .frame(height: 220)
        .ignoresSafeArea(edges: .top)
    }
}
