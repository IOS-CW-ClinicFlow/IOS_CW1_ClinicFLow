//
//  PaymentSectionCard.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-051 on 2026-03-10.
//
import SwiftUI

struct PaymentSectionCard: View {
    let title:    String
    let methods:  [PaymentMethod]
    let selected: PaymentMethod
    var onSelect: (PaymentMethod) -> Void = { _ in }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(Color(hex: "#1a1a1a"))
                .padding(.bottom, 14)

            VStack(spacing: 0) {
                ForEach(Array(methods.enumerated()), id: \.element.id) { index, method in
                    PaymentOptionRow(
                        method:      method,
                        isSelected:  selected == method,
                        showDivider: index < methods.count - 1,
                        onTap:       { onSelect(method) }
                    )
                }
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 2)
        }
    }
}
