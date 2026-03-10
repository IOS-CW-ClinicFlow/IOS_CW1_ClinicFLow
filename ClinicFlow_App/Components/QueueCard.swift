//
//  QueueCard.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct QueueCard: View {
    let label:      String
    let value:      String
    let unit:       String?         // e.g. "min" suffix, nil for plain numbers
    let isHighlighted: Bool
    var highlightColor: Color = Color(hex: "#2196F3") // default blue

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {

            // Label
            Text(label.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(isHighlighted ? highlightColor : Color(hex: "#AAAAAA"))
                .kerning(0.5)

            // Number + optional unit
            HStack(alignment: .lastTextBaseline, spacing: 1) {
                Text(value)
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(isHighlighted ? highlightColor : Color(hex: "#1a1a1a"))
                    .kerning(-0.5)
                if let unit {
                    Text(unit)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(isHighlighted ? highlightColor : Color(hex: "#1a1a1a"))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(isHighlighted ? highlightColor.opacity(0.15) : Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    isHighlighted ? highlightColor : Color(hex: "#E0E0E8"),
                    lineWidth: isHighlighted ? 2 : 1.5
                )
        )
    }
}

#Preview {
    HStack(spacing: 10) {
        QueueCard(label: "Current",  value: "12", unit: nil,   isHighlighted: false)
        QueueCard(label: "Your No.", value: "21", unit: nil,   isHighlighted: true)
        QueueCard(label: "Wait",     value: "5",  unit: "min", isHighlighted: false)
    }
    .padding()
}
