//
//  PackageRadio.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct PackageRadio: View {
    let isSelected: Bool

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(
                    isSelected ? Color(hex: "#1A8FD1") : Color(hex: "#D0D0E0"),
                    lineWidth: 2
                )
                .background(
                    Circle()
                        .fill(isSelected ? Color(hex: "#1A8FD1") : .white)
                )
                .frame(width: 22, height: 22)

            if isSelected {
                Circle()
                    .fill(.white)
                    .frame(width: 8, height: 8)
            }
        }
    }
}
