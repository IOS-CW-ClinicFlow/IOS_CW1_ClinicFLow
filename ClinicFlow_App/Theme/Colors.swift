//
//  Colors.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//

import SwiftUI

extension Color {

    // ── Brand ──────────────────────────────────────────────────────────────
    static let cfBlue     = Color(hex: "#2a9df4")
    static let cfBlueDark = Color(hex: "#1A6FE0")

    // ── Backgrounds ────────────────────────────────────────────────────────
    static let cfBackground = Color(hex: "#fafafa")

    // ── Borders ────────────────────────────────────────────────────────────
    static let cfBorder = Color(hex: "#e0e0e5")

    // ── Text ───────────────────────────────────────────────────────────────
    static let cfText    = Color(hex: "#1a1a1a")
    static let cfSubtext = Color(hex: "#888888")

    // ── Navigation ─────────────────────────────────────────────────────────
    static let cfNavInactive = Color(hex: "#aaaaaa")
    // ── Error color ─────────────────────────────────────────────────────────
    static let cfError = Color.red
}


// ── Hex initialiser ────────────────────────────────────────────────────────────

extension Color {
    /// Initialise a `Color` from a CSS-style hex string, e.g. `"#2a9df4"`.
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6:
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 0) // fallback – visible bright yellow
        }
        self.init(
            red:   Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255
        )
    }
}
// ─── MARK: Home screen tokens ─────────────────────────────────────────────────
// Screen-specific colours & style constants for HomeScreen.
// Kept here so all colour values live in one file.

enum HomeTheme {

    // ── Backgrounds ────────────────────────────────────────────────────────
    static let pageBg    = Color(hex: "#F4F6FB")
    static let headerBg  = Color.white
    static let cardBg    = Color.white

    // ── Current Appointment card ───────────────────────────────────────────
    static let appointmentGreen    = Color(hex: "#2ECC88")
    static let appointmentShadow   = Color(hex: "#2ECC88").opacity(0.4)
    static let appointmentFooterBg = Color.black.opacity(0.18)

    // ── Category icon circles ──────────────────────────────────────────────
    static let categoryCircleBg = Color(hex: "#EAF4FE")
    static let categoryIcon     = Color(hex: "#2196F3")

    // ── Filter / search ────────────────────────────────────────────────────
    static let filterButtonBg     = Color(hex: "#2196F3")
    static let filterButtonShadow = Color(hex: "#2196F3").opacity(0.4)
    static let searchBorder       = Color(hex: "#E8E8EE")
    static let searchPlaceholder  = Color(hex: "#C8C8D0")
    static let searchIcon         = Color(hex: "#BBBBCC")

    // ── Top-bar pills (bell / EN badge) ───────────────────────────────────
    static let pillBg   = Color(hex: "#F2F2F7")
    static let notifDot = Color(hex: "#F44336")

    // ── Rating badge ───────────────────────────────────────────────────────
    static let ratingStarColor = Color(hex: "#FFC107")
    static let ratingTextColor = Color(hex: "#333333")

    // ── Section header ─────────────────────────────────────────────────────
    static let seeAllColor = Color(hex: "#2196F3")

    // ── Card shadow ────────────────────────────────────────────────────────
    static let cardShadow = Color.black.opacity(0.08)

    // ── Typography ─────────────────────────────────────────────────────────
    static let sectionTitleSize:   CGFloat     = 18
    static let sectionTitleWeight: Font.Weight = .heavy

    // ── Layout ─────────────────────────────────────────────────────────────
    static let cardCornerRadius:  CGFloat = 16
    static let cardShadowRadius:  CGFloat = 12
}
