//
//  ServicePlaceCard.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct ServicePlaceCard: View {
    let place: ServicePlace
    var onTap: () -> Void = {}

    var body: some View {
        Button { onTap() } label: {
            VStack(spacing: 0) {

                // ── Image area ─────────────────────────────────────────────
                ZStack(alignment: .top) {
                    ZStack {
                        Color(hex: "#D0E8F5")
                        Image(place.imageName)
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(height: 130)
                    .clipped()

                    // Heart top-left, status top-right
                    HStack {
                        HeartButton(isFilled: false)
                            .padding(10)
                        Spacer()
                        StatusPill(isOpen: place.isOpen)
                            .padding(10)
                    }
                }
                .frame(height: 130)

                // ── Info area ──────────────────────────────────────────────
                VStack(alignment: .leading, spacing: 0) {
                    Text(place.name)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 2)

                    Text(place.category)
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "#999999"))
                        .padding(.bottom, 9)

                    HStack(spacing: 5) {
                        MapPinCircleIcon(size: 12)
                        Text(place.location)
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#555555"))
                    }
                    .padding(.bottom, 5)

                    HStack(spacing: 5) {
                        Image(systemName: "clock.fill")
                                .font(.system(size: 12))
                                .foregroundColor(Color(hex: "#2196F3"))
                        Text(place.hours)
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#555555"))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 14)
                .padding(.vertical, 12)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.07), radius: 12, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ServicePlaceCard(place: ServicesData.labs[0])
        .padding()
}
