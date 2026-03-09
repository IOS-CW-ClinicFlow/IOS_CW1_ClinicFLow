//
//  MapPinView.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-09.
//
//
import SwiftUI

// ── Triangle tail for pin ─────────────────────────────────────────────────────

struct PinTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

// ── Reusable pin view ─────────────────────────────────────────────────────────

struct MapPinView: View {
    var color: Color
    var hasDot: Bool     = true
    var pulsing: Bool    = false
    var label: String    = ""
    var distance: String = ""
    var time: String     = ""

    @Binding var selectedLabel: String   // shared across all pins

    @State private var pulse = false

    private var isSelected: Bool { selectedLabel == label }

    var body: some View {
        ZStack(alignment: .bottom) {

            // ── Callout bubble ─────────────────────────────────────────────
            if isSelected && !label.isEmpty {
                calloutView
                    .offset(y: -52)
                    .transition(.scale(scale: 0.85, anchor: .bottom).combined(with: .opacity))
                    .zIndex(10)
            }

            // ── Pin body ───────────────────────────────────────────────────
            VStack(spacing: 0) {
                ZStack {
                    if pulsing {
                        Circle()
                            .fill(color.opacity(0.2))
                            .frame(width: pulse ? 54 : 38, height: pulse ? 54 : 38)
                            .animation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true), value: pulse)
                            .onAppear { pulse = true }
                    }
                    Circle()
                        .fill(color)
                        .frame(width: 30, height: 30)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 11, height: 11)
                    if hasDot {
                        Circle()
                            .fill(color)
                            .frame(width: 5, height: 5)
                    }
                }
                PinTriangle()
                    .fill(color)
                    .frame(width: 11, height: 9)
            }
            .onTapGesture {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selectedLabel = isSelected ? "" : label
                }
            }
        }
    }

    // ── Callout ────────────────────────────────────────────────────────────

    private var calloutView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(Color(hex: "#1a1a1a"))

            HStack(spacing: 12) {
                HStack(spacing: 5) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(color)
                        .font(.system(size: 13))
                    Text(distance)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color(hex: "#444444"))
                }
                HStack(spacing: 5) {
                    Image(systemName: "clock.fill")
                        .foregroundColor(color)
                        .font(.system(size: 13))
                    Text(time)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color(hex: "#444444"))
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.18), radius: 10, x: 0, y: 3)
        )
        .fixedSize()   // prevents callout from being clipped/shrunk
        .overlay(alignment: .bottom) {
            // Small downward triangle connector
            PinTriangle()
                .fill(Color.white)
                .frame(width: 14, height: 8)
                .offset(y: 7)
        }
    }
}

#Preview {
    ZStack {
        Color(hex: "#F4F6FB").ignoresSafeArea()
        MapPinView(
            color: Color(hex: "#2196F3"),
            hasDot: true,
            label: "Special Ward-1",
            distance: "120m",
            time: "2 min",
            selectedLabel: .constant("Special Ward-1")
        )
    }
    .frame(width: 300, height: 300)
}
