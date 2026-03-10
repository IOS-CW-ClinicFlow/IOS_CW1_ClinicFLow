//
//  SuccessDetailRow.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import SwiftUI

struct SuccessDetailRow: View {
    let detail: SuccessDetail

    var body: some View {
        HStack(spacing: 10) {
            // Icon bubble
            ZStack {
                Circle()
                    .fill(Color(hex: "#EEF6FF"))
                    .frame(width: 34, height: 34)
                Image(systemName: detail.iconName)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color(hex: detail.iconColor))
            }

            Text(detail.value)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(Color(hex: detail.valueColor))
                .lineLimit(1)
                .minimumScaleFactor(0.85)
        }
    }
}
