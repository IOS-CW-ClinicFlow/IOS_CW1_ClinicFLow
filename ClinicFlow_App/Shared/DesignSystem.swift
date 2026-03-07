// DesignSystem.swift
// Clinic Flow – Shared design tokens, icons, and reusable primitives.
// Corresponds to: shared.tsx

import SwiftUI

// ─── MARK: Colours ────────────────────────────────────────────────────────────

extension Color {
    static let cfBlue       = Color(hex: "#2a9df4")
    static let cfBlueDark   = Color(hex: "#1A6FE0")
    static let cfBackground = Color(hex: "#fafafa")
    static let cfBorder     = Color(hex: "#e0e0e5")
    static let cfText       = Color(hex: "#1a1a1a")
    static let cfSubtext    = Color(hex: "#888888")
    static let cfNavInactive = Color(hex: "#aaaaaa")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6:
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 0)
        }
        self.init(
            red:   Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255
        )
    }
}

// ─── MARK: Typography ─────────────────────────────────────────────────────────

extension Font {
    // SF Pro Display is the system font on iOS — no extra import needed.
    static func cfDisplay(size: CGFloat, weight: Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

// ─── MARK: Icons ──────────────────────────────────────────────────────────────

struct BackArrowIcon: View {
    var body: some View {
        Image(systemName: "arrow.left")
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(.cfText)
    }
}

struct CheckIcon: View {
    var body: some View {
        Image(systemName: "checkmark")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.white)
    }
}

// ─── MARK: Status Bar ─────────────────────────────────────────────────────────
// Decorative status bar that mimics the iPhone 16 shell look.

struct CFStatusBar: View {
    var body: some View {
        ZStack {
            Color.white

            // Dynamic Island pill
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black)
                .frame(width: 120, height: 34)
                .offset(y: -6)

            HStack {
                // Time
                Text("9:41")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.cfText)
                    .kerning(-0.3)

                Spacer()

                // Status icons
                HStack(spacing: 5) {
                    Image(systemName: "cellularbars")
                        .font(.system(size: 13, weight: .medium))
                    Image(systemName: "wifi")
                        .font(.system(size: 13, weight: .medium))
                    Image(systemName: "battery.75")
                        .font(.system(size: 13, weight: .medium))
                }
                .foregroundColor(.cfText)
            }
            .padding(.horizontal, 28)
            .padding(.top, 14)
        }
        .frame(height: 59)
    }
}

// ─── MARK: Home Indicator ─────────────────────────────────────────────────────

struct CFHomeIndicator: View {
    var body: some View {
        ZStack {
            Color.white
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.black.opacity(0.18))
                .frame(width: 134, height: 5)
        }
        .frame(height: 34)
    }
}

// ─── MARK: Phone Shell ────────────────────────────────────────────────────────
// Wraps any screen content in the iPhone 16 hardware frame.

struct PhoneShell<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .frame(width: 393, height: 852)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 54))
        .overlay(
            RoundedRectangle(cornerRadius: 54)
                .stroke(Color(hex: "#b0b0b5"), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.38), radius: 40, x: 0, y: 30)
    }
}

// ─── MARK: Bottom Navigation Bar ──────────────────────────────────────────────

enum CFTab: String, CaseIterable {
    case home         = "Home"
    case services     = "Services"
    case appointments = "Appointments"
    case map          = "Map"
    case profile      = "Profile"

    var systemImage: String {
        switch self {
        case .home:         return "house"
        case .services:     return "squares.below.rectangle" // closest to 4-grid
        case .appointments: return "calendar"
        case .map:          return "map"
        case .profile:      return "person"
        }
    }
}

struct BottomNav: View {
    let active: CFTab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(CFTab.allCases, id: \.self) { tab in
                let isActive = tab == active

                VStack(spacing: 3) {
                    if tab == .services && isActive {
                        // Floating circle for active Services tab
                        ZStack {
                            Circle()
                                .fill(Color.cfBlue)
                                .frame(width: 36, height: 36)
                                .shadow(color: Color.cfBlue.opacity(0.4), radius: 6, x: 0, y: 4)
                            Image(systemName: tab.systemImage)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .offset(y: -18)
                    } else {
                        Image(systemName: tab.systemImage)
                            .font(.system(size: 20, weight: isActive ? .semibold : .regular))
                            .foregroundColor(isActive ? .cfBlue : .cfNavInactive)
                    }

                    Text(tab.rawValue)
                        .font(.system(size: 10, weight: isActive ? .semibold : .regular))
                        .foregroundColor(isActive ? .cfBlue : .cfNavInactive)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(Color(hex: "#f0f0f5"))
                .frame(height: 1),
            alignment: .top
        )
    }
}

// ─── MARK: Previews ───────────────────────────────────────────────────────────

#Preview("Status Bar") {
    CFStatusBar()
        .frame(width: 393)
}

#Preview("Bottom Nav") {
    BottomNav(active: .home)
        .frame(width: 393)
}
