//
//  LabTestRow.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct LabTestRow: View {
    let test: LabTest
    var onTap: () -> Void = {}

    var body: some View {
        HStack {

            // Name + optional urgent badge
            HStack(spacing: 10) {
                Text(test.name)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color(hex: "#1a1a1a"))

                if test.urgency == .urgent {
                    Text("URGENT")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white)
                        .kerning(0.3)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(Color(hex: "#FF5252"))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }

            Spacer()

            // Go button
            Button { onTap() } label: {
                Text("Go to \(test.destination)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(hex: "#1A8FD1"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color(hex: "#E8E8EE"), lineWidth: 1.5)
        )
    }
}
