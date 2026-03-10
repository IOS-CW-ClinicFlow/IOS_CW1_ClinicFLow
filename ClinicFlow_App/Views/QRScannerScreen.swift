//
//  QRScannerScreen.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

// ── QR Code drawn with SwiftUI Canvas ────────────────────────────────────────

private struct QRCodeView: View {

    var body: some View {
        Canvas { ctx, size in
            let s = size.width / 200

            func rect(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat,
                      r: CGFloat = 0, fill: Color = Color(hex: "#1a1a1a")) {
                let path = RoundedRectangle(cornerRadius: r * s)
                    .path(in: CGRect(x: x*s, y: y*s, width: w*s, height: h*s))
                ctx.fill(path, with: .color(fill))
            }

            rect(0, 0, 200, 200, fill: .white)

            // Position squares
            rect(10,10,56,56,r:4); rect(18,18,40,40,r:2,fill:.white); rect(26,26,24,24,r:1)
            rect(134,10,56,56,r:4); rect(142,18,40,40,r:2,fill:.white); rect(150,26,24,24,r:1)
            rect(10,134,56,56,r:4); rect(18,142,40,40,r:2,fill:.white); rect(26,150,24,24,r:1)

            // Top centre
            for x in [76,92,108,124] as [CGFloat] { rect(x,10,8,8) }
            for x in [84,100,116]    as [CGFloat] { rect(x,20,8,8) }
            for x in [76,92,108,124] as [CGFloat] { rect(x,30,8,8) }
            for x in [80,96,112]     as [CGFloat] { rect(x,42,8,8) }
            for x in [76,100,120]    as [CGFloat] { rect(x,54,8,8) }

            // Left column
            for x in [10,26,42,58]  as [CGFloat] { rect(x,76,8,8) }
            for x in [18,34,50]     as [CGFloat] { rect(x,88,8,8) }
            for x in [10,26,42,58]  as [CGFloat] { rect(x,100,8,8) }
            for x in [18,34,50]     as [CGFloat] { rect(x,112,8,8) }
            for x in [10,42,58]     as [CGFloat] { rect(x,124,8,8) }

            // Centre block
            for x in [76,92,108,124,140] as [CGFloat] { rect(x,76,8,8) }
            for x in [84,100,116,132]    as [CGFloat] { rect(x,88,8,8) }
            for x in [76,92,108,124,140] as [CGFloat] { rect(x,100,8,8) }
            for x in [80,96,128,144]     as [CGFloat] { rect(x,112,8,8) }
            for x in [76,92,108,136]     as [CGFloat] { rect(x,124,8,8) }

            // Right-bottom
            for x in [134,150,166,182]   as [CGFloat] { rect(x,76,8,8) }
            for x in [142,158,174]       as [CGFloat] { rect(x,88,8,8) }
            for x in [134,150,182]       as [CGFloat] { rect(x,100,8,8) }
            for x in [158,174]           as [CGFloat] { rect(x,112,8,8) }
            for x in [134,150,166]       as [CGFloat] { rect(x,124,8,8) }

            // Bottom centre
            for x in [76,92,108,124,140] as [CGFloat] { rect(x,150,8,8) }
            for x in [84,100,116]        as [CGFloat] { rect(x,162,8,8) }
            for x in [76,92,108,132]     as [CGFloat] { rect(x,174,8,8) }
            for x in [80,124,140]        as [CGFloat] { rect(x,182,8,8) }
        }
        .frame(width: 200, height: 200)
    }
}

// ── Screen ────────────────────────────────────────────────────────────────────

struct QRScannerScreen: View {

    var onCapture: () -> Void = {}
    var onBack:    () -> Void = {}

    var body: some View {
        VStack(spacing: 0) {

            // ── Top bar — white text on blue matches iOS 16+ tinted nav ────
            TopBar(title: "Scan QR", showBack: true, onBack: onBack)

            // ── Blue content area ──────────────────────────────────────────
            ZStack {
                LinearGradient(
                    colors: [Color(hex: "#1A73E8"), Color(hex: "#1557C0")],
                    startPoint: .top,
                    endPoint: .bottom
                )

                VStack {
                    Spacer()

                    // Hint text
                    Text("Hold your device steady over the QR code")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 32)

                    // QR card
                    QRCodeView()
                        .padding(20)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .black.opacity(0.3), radius: 40, x: 0, y: 12)

                    Spacer()

                    // Camera button
                    VStack(spacing: 10) {
                        Button { onCapture() } label: {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: 64, height: 64)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white.opacity(0.5), lineWidth: 2)
                                    )
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 24, weight: .medium))
                                    .foregroundColor(.white)
                            }
                        }
                        .buttonStyle(.plain)

                        Text("Tap to capture")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.bottom, 48)
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    QRScannerScreen()
}
