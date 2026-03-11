//
//  SplashScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
//
//  SplashScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct SplashScreen: View {
    var onTap: () -> Void

    private let autoAdvanceDelay: Double = 3.0

    @State private var progress: CGFloat = 0.0

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            SplashContent(progress: progress)
        }
        .onTapGesture { onTap() }
        .onAppear {
            // Start progress bar
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                progress = 1.0
            }
            // Auto-advance
            DispatchQueue.main.asyncAfter(deadline: .now() + autoAdvanceDelay) {
                onTap()
            }
        }
    }
}

// ─── MARK: Inner content ──────────────────────────────────────────────────────

private struct SplashContent: View {
    let progress: CGFloat

    private let autoAdvanceDelay: Double = 3.0

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {

                Color.white
                    .ignoresSafeArea()

                DiagonalWave()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.white.opacity(0.2),           location: 0.0),
                                .init(color: Color.white.opacity(0.5),           location: 0.5),
                                .init(color: Color(hex: "#0a4cf4").opacity(0.7), location: 1.0),
                            ]),
                            startPoint: UnitPoint(x: 0.0, y: 0.1),
                            endPoint:   UnitPoint(x: 0.7, y: 1.0)
                        )
                    )
                    .frame(height: 260)

                // ── Logo + text + progress bar ────────────────────────────
                VStack(spacing: 0) {
                    Image("clinic_flow_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .padding(.bottom, 20)

                    Text("Welcome to")
                        .font(.cfDisplay(size: 20, weight: .regular))
                        .foregroundColor(.cfSubtext)
                        .kerning(0.2)
                        .padding(.bottom, 4)

                    Text("Clinic Flow")
                        .font(.cfDisplay(size: 30, weight: .bold))
                        .foregroundColor(.cfBlueDark)
                        .padding(.bottom, 32)

                    // ── Progress bar ──────────────────────────────────────
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color(hex: "#0a4cf4").opacity(0.15))
                            .frame(width: 160, height: 4)

                        Capsule()
                            .fill(Color(hex: "#0a4cf4"))
                            .frame(width: 160 * progress, height: 4)
                            .animation(
                                .linear(duration: autoAdvanceDelay),
                                value: progress
                            )
                    }
                }
                .padding(.bottom, 140)
            }
        }
    }
}

// ─── MARK: Diagonal wave shape ────────────────────────────────────────────────

private struct DiagonalWave: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width
        let h = rect.height
        let topLeft  = CGPoint(x: 0, y: h * (230 / 260))
        let topRight = CGPoint(x: w, y: h * (80  / 260))
        let botRight = CGPoint(x: w, y: h)
        let botLeft  = CGPoint(x: 0, y: h)

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
    SplashScreen(onTap: {})
}
