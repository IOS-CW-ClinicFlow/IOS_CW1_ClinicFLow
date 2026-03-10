//
//  PaymentRadio.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-051 on 2026-03-10.
//
import SwiftUI

struct PaymentRadio: View {
    let isSelected: Bool

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(
                    isSelected ? Color(hex: "#2196F3") : Color(hex: "#DDDDEE"),
                    lineWidth: 2
                )
                .frame(width: 22, height: 22)

            if isSelected {
                Circle()
                    .fill(Color(hex: "#2196F3"))
                    .frame(width: 22, height: 22)

                Circle()
                    .fill(Color.white)
                    .frame(width: 8, height: 8)
            }
        }
        .animation(.easeInOut(duration: 0.15), value: isSelected)
    }
}
