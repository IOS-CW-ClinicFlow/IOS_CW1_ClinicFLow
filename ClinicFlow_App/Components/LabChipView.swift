//
//  LabChipView.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import SwiftUI

struct LabChipView: View {
    let chip: LabChip

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: chip.iconName)
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(Color(hex: chip.colorHex))
            Text(chip.label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color(hex: chip.colorHex))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color.white)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color(hex: chip.colorHex).opacity(0.25), lineWidth: 1.5)
        )
    }
}
