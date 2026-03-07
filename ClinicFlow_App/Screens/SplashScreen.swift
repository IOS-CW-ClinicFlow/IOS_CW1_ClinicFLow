// SplashScreen.swift
// Clinic Flow – Landing / Splash screen.
// Corresponds to: LandingPage.tsx  (SplashScreen export)

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        // Outer canvas — mirrors the grey `#e5e5ea` page background
        ZStack {
            Color(hex: "#e5e5ea").ignoresSafeArea()

            PhoneShell {
                CFStatusBar()
                SplashContent()
                CFHomeIndicator()
            }
        }
    }
}

// ─── MARK: Inner content ──────────────────────────────────────────────────────

private struct SplashContent: View {
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {

                Color.white

                // ── Diagonal wave (bottom-right fill) ─────────────────────────
                // Exactly mirrors SVG:
                //   path   : M0,230 L393,80 L393,260 L0,260 Z  (viewBox 393×260)
                //   gradient: x1="0%" y1="10%" x2="70%" y2="100%"
                //   stops  : #fff @0% op0.2 → #fff @50% op0.5 → #0a4cf4 @100% op0.7
                DiagonalWave()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.white.opacity(0.2),           location: 0.0),
                                .init(color: Color.white.opacity(0.5),           location: 0.5),
                                .init(color: Color(hex: "#0a4cf4").opacity(0.7), location: 1.0),
                            ]),
                            // x1=0% y1=10%  →  x2=70% y2=100%  matches SVG linearGradient
                            startPoint: UnitPoint(x: 0.0, y: 0.1),
                            endPoint:   UnitPoint(x: 0.7, y: 1.0)
                        )
                    )
                    .frame(height: 260)

                // ── Logo + text block ─────────────────────────────────────────
                VStack(spacing: 0) {
                    // Logo — exactly 400×400 as in the original (objectFit: contain)
                    Image("clinic_flow_logo")          // add PNG to Assets.xcassets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .padding(.bottom, 20)

                    // "Welcome to"
                    Text("Welcome to")
                        .font(.cfDisplay(size: 20, weight: .regular))
                        .foregroundColor(.cfSubtext)
                        .kerning(0.2)
                        .padding(.bottom, 4)

                    // "Clinic Flow"
                    Text("Clinic Flow")
                        .font(.cfDisplay(size: 30, weight: .bold))
                        .foregroundColor(.cfBlueDark)
                }
                // Mirrors `marginBottom: "110px"` — lift the block above the wave
                .padding(.bottom, 110)
            }
        }
    }
}

// ─── MARK: Diagonal wave shape ────────────────────────────────────────────────
// Replicates: M0,230 L393,80 L393,260 L0,260 Z  (viewBox 393×260)

private struct DiagonalWave: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height                 // maps to 260 in the original
        let topLeft  = CGPoint(x: 0,   y: h * (230 / 260))   // 0,230
        let topRight = CGPoint(x: w,   y: h * (80  / 260))   // 393,80
        let botRight = CGPoint(x: w,   y: h)
        let botLeft  = CGPoint(x: 0,   y: h)

        var path = Path()
        path.move(to: topLeft)
        path.addLine(to: topRight)
        path.addLine(to: botRight)
        path.addLine(to: botLeft)
        path.closeSubpath()
        return path
    }
}

// ─── MARK: Preview ────────────────────────────────────────────────────────────

#Preview {
    SplashScreen()
}
