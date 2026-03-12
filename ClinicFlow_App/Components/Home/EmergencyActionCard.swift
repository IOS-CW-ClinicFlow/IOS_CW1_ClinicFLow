//
//  EmergencyActionCard.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-10.
//
import SwiftUI

struct EmergencyActionCard: View {
    let action:    EmergencyActionType
    var onTap:     () -> Void = {}

    @State private var isPressed = false

    var body: some View {
        Button { onTap() } label: {
            HStack(spacing: 16) {

                // Icon bubble
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color(hex: action.accentColorHex).opacity(0.12))
                        .frame(width: 56, height: 56)
                    Image(systemName: action.icon)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(Color(hex: action.accentColorHex))
                }

                // Text
                VStack(alignment: .leading, spacing: 4) {
                    Text(action.rawValue)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                    Text(action.description)
                        .font(.system(size: 12))
                        .foregroundStyle(Color(hex: "#888888"))
                        .lineLimit(1)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color(hex: "#CCCCCC"))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color(hex: action.accentColorHex).opacity(0.08),
                    radius: 10, x: 0, y: 3)
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isPressed)
        }
        .buttonStyle(.plain)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded   { _ in isPressed = false }
        )
    }
}
