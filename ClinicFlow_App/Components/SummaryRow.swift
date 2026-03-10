//
//  SummaryRow.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import SwiftUI

struct SummaryRow: View {
    let label: String
    let value: String
    var showDivider: Bool = true

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(label)
                    .font(.system(size: 14))
                    .foregroundStyle(Color(hex: "#AAAAAA"))
                Spacer()
                Text(value)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color(hex: "#1a1a1a"))
            }
            .padding(.vertical, 14)

            if showDivider {
                Rectangle()
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(height: 1)
            }
        }
    }
}
