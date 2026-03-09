//
//  SearchBar.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-09.
//
import SwiftUI

struct SearchBar: View {
    var placeholder: String = "Search"
    var onFilterTap: () -> Void = {}

    var body: some View {
        HStack(spacing: 9) {

            // ── Search field ───────────────────────────────────────────────
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#BBBBCC"))
                Text(placeholder)
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#C8C8D0"))
                Spacer()
            }
            .padding(.horizontal, 14)
            .frame(height: 42)
            .background(Color(hex: "#F5F5FA"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(hex: "#EBEBF0"), lineWidth: 1)
            )

            // ── Filter button ──────────────────────────────────────────────
            Button { onFilterTap() } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 11)
                        .fill(Color(hex: "#2196F3"))
                        .frame(width: 42, height: 42)
                        .shadow(color: Color(hex: "#2196F3").opacity(0.38), radius: 12, x: 0, y: 4)
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 12)
        .background(Color.white)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color(hex: "#F0F0F5"))
                .frame(height: 1)
        }
    }
}

// ── Preview ───────────────────────────────────────────────────────────────────

#Preview {
    VStack(spacing: 0) {
        SearchBar(placeholder: "Search")
        SearchBar(placeholder: "Search Doctor, Hospital")
        SearchBar(placeholder: "Search Services")
        SearchBar(placeholder: "Search Location")
        Spacer()
    }
}
