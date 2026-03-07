// PhoneVerifiedScreen.swift
// Clinic Flow – Phone number verified success screen.
// Corresponds to: Verified.tsx  (PhoneVerifiedScreen export)
//
// Usage:
//   PhoneVerifiedScreen(onContinue: { /* navigate to home */ })

import SwiftUI

struct PhoneVerifiedScreen: View {
    var onContinue: () -> Void = {}

    var body: some View {
        ZStack {
            Color(hex: "#1a1a1a").ignoresSafeArea()

            PhoneShell {
                CFStatusBar()
                VerifiedContent(onContinue: onContinue)
                CFHomeIndicator()
            }
        }
    }
}

// ─── MARK: Inner content ──────────────────────────────────────────────────────

private struct VerifiedContent: View {
    var onContinue: () -> Void

    // Animation states
    @State private var checkScale:   CGFloat = 0
    @State private var checkOpacity: CGFloat = 0
    @State private var textOpacity:  CGFloat = 0

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // ── Animated check circle ─────────────────────────────────────────
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "#2a9df4"), Color(hex: "#1a7fd4")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 96, height: 96)
                    .shadow(color: Color.cfBlue.opacity(0.35), radius: 15, x: 0, y: 8)

                CheckIcon()
            }
            .scaleEffect(checkScale)
            .opacity(checkOpacity)
            .padding(.bottom, 28)

            // ── Heading ───────────────────────────────────────────────────────
            Text("Phone Number Verified")
                .font(.cfDisplay(size: 24, weight: .bold))
                .foregroundColor(.cfText)
                .kerning(-0.5)
                .multilineTextAlignment(.center)
                .padding(.bottom, 12)

            // ── Subtitle ──────────────────────────────────────────────────────
            Text("You will be redirected to the main page in a few moments")
                .font(.cfDisplay(size: 15))
                .foregroundColor(Color(hex: "#8e8e93"))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .frame(maxWidth: 240)

            // ── Bouncing dots ─────────────────────────────────────────────────
            BouncingDots()
                .padding(.top, 36)

            // ── Continue now button ───────────────────────────────────────────
            Button(action: onContinue) {
                Text("Continue now →")
                    .font(.cfDisplay(size: 14, weight: .semibold))
                    .foregroundColor(.cfBlue)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
            }
            .buttonStyle(.plain)
            .padding(.top, 40)

            Spacer()
        }
        .opacity(textOpacity)
        .onAppear {
            // Pop-in animation for the check circle — matches CSS cubic-bezier(0.34,1.56,0.64,1)
            withAnimation(.interpolatingSpring(stiffness: 200, damping: 12).delay(0.05)) {
                checkScale   = 1
                checkOpacity = 1
            }
            // Fade in rest of content slightly after
            withAnimation(.easeOut(duration: 0.35).delay(0.15)) {
                textOpacity = 1
            }
            // Auto-redirect after 3.5 s
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                onContinue()
            }
        }
    }
}

// ─── MARK: Bouncing dots ──────────────────────────────────────────────────────
// Mirrors CSS dotBounce: scale 0.7/opacity 0.4 → scale 1/opacity 1 → repeat

private struct BouncingDots: View {
    @State private var animate = false

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3, id: \.self) { i in
                Circle()
                    .fill(Color.cfBlue)
                    .frame(width: 8, height: 8)
                    .scaleEffect(animate ? 1.0 : 0.7)
                    .opacity(animate ? 1.0 : 0.4)
                    .animation(
                        .easeInOut(duration: 0.6)
                        .repeatForever(autoreverses: true)
                        .delay(Double(i) * 0.2),
                        value: animate
                    )
            }
        }
        .onAppear { animate = true }
    }
}

// ─── MARK: Preview ────────────────────────────────────────────────────────────

#Preview {
    PhoneVerifiedScreen()
}
