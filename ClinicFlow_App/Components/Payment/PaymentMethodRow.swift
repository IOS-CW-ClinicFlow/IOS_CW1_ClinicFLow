//
//  PaymentMethodRow.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import SwiftUI

struct PaymentMethodRow: View {
    let method:    PaymentMethod
    var onChange:  () -> Void = {}

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: method.iconName)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(Color(hex: method.iconColorHex))
                .frame(width: 24)

            Text(method.rawValue)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color(hex: "#1a1a1a"))

            Spacer()

            Button("Change", action: onChange)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(Color(hex: "#1A8FD1"))
                .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color(hex: "#F8F8FC"))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}
