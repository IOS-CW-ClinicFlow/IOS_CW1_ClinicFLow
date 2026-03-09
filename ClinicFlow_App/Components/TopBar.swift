//
//  TopBar.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-09.
//
import SwiftUI

struct TopBar: View {
    var title: String
    var showBack: Bool        = false
    var showSearch: Bool      = false
    var isSearchActive: Bool  = false
    var onBack:   () -> Void  = {}
    var onSearch: () -> Void  = {}

    var body: some View {
        HStack {

            // ── Left: back button or spacer ────────────────────────────────
            if showBack {
                Button { onBack() } label: {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#F2F2F7"))
                            .frame(width: 36, height: 36)
                        Image(systemName: "chevron.left")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color(hex: "#1a1a1a"))
                    }
                }
                .buttonStyle(.plain)
            } else {
                Spacer().frame(width: 36)
            }

            Spacer()

            // ── Centre: title ──────────────────────────────────────────────
            Text(title)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(Color(hex: "#1a1a1a"))
                .kerning(-0.3)

            Spacer()

            // ── Right: search button or spacer ─────────────────────────────
            if showSearch {
                Button { onSearch() } label: {
                    ZStack {
                        Circle()
                            .fill(isSearchActive ? Color(hex: "#2196F3") : Color(hex: "#F2F2F7"))
                            .frame(width: 36, height: 36)
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(isSearchActive ? .white : Color(hex: "#555555"))
                    }
                }
                .buttonStyle(.plain)
            } else {
                Spacer().frame(width: 36)
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 12)
        .padding(.bottom, 8)
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
        TopBar(title: "Map", showBack: true)
        TopBar(title: "Services", showBack: true, showSearch: true)
        TopBar(title: "Services", showBack: true, showSearch: true, isSearchActive: true)
        Spacer()
    }
}
