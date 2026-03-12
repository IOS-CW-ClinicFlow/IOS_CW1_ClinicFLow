//
//  PackageRow.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct PackageRow: View {
    let package_:   ConsultationPackage
    let isSelected: Bool
    var onTap:      () -> Void = {}

    var body: some View {
        Button { onTap() } label: {
            HStack(spacing: 14) {

                // Icon bubble
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(hex: "#EAF4FE"))
                        .frame(width: 46, height: 46)
                    Image(systemName: package_.icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(Color(hex: "#1A8FD1"))
                }

                // Label + description
                VStack(alignment: .leading, spacing: 3) {
                    Text(package_.label)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                    Text(package_.description)
                        .font(.system(size: 12))
                        .foregroundStyle(Color(hex: "#AAAAAA"))
                }

                Spacer()

                // Price + radio
                VStack(alignment: .trailing, spacing: 6) {
                    HStack(alignment: .lastTextBaseline, spacing: 2) {
                        Text(package_.price)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color(hex: "#1a1a1a"))
                        Text(package_.duration)
                            .font(.system(size: 11))
                            .foregroundStyle(Color(hex: "#AAAAAA"))
                    }
                    PackageRadio(isSelected: isSelected)
                }
            }
            .padding(16)
            .background(isSelected ? Color(hex: "#F0F8FF") : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(
                        isSelected ? Color(hex: "#1A8FD1") : Color(hex: "#E8E8F0"),
                        lineWidth: 1.5
                    )
            )
            .animation(.easeInOut(duration: 0.15), value: isSelected)
        }
        .buttonStyle(.plain)
    }
}
