//
//  PaymentOptionRow.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-051 on 2026-03-10.
//
import SwiftUI

struct PaymentOptionRow: View {
    let method:     PaymentMethod
    let isSelected: Bool
    var showDivider: Bool = false
    var onTap: () -> Void = {}

    var body: some View {
        Button { onTap() } label: {
            VStack(spacing: 0) {
                HStack(spacing: 14) {

                    // Icon bubble
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(hex: "#F4F6FB"))
                            .frame(width: 38, height: 38)
                        Image(systemName: method.iconName)
                            .font(.system(size: 17, weight: .medium))
                            .foregroundStyle(Color(hex: method.iconColorHex))
                    }

                    Text(method.rawValue)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))

                    Spacer()

                    PaymentRadio(isSelected: isSelected)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 15)

                if showDivider {
                    Rectangle()
                        .fill(Color(hex: "#F2F2F7"))
                        .frame(height: 1)
                        .padding(.leading, 68) // aligns with text, not icon
                }
            }
        }
        .buttonStyle(.plain)
    }
}
