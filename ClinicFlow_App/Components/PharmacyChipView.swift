//
//  PharmacyChipView.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-11.
//
import SwiftUI

struct PharmacyChipView: View {
    let chip: PharmacyChip

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: chip.iconName)
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(Color(hex: chip.colorHex))
            Text(chip.label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color(hex: chip.colorHex))
        }
        .padding(.horizontal, 11)
        .padding(.vertical, 6)
        .background(Color(hex: chip.colorHex).opacity(0.08))
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color(hex: chip.colorHex), lineWidth: 1.2))
    }
}
