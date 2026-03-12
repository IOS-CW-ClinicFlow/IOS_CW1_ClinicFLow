//
//  StatusPill.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct StatusPill: View {
    let isOpen: Bool

    var body: some View {
        Text(isOpen ? "OPEN" : "CLOSED")
            .font(.system(size: 11, weight: .bold))
            .foregroundColor(.white)
            .padding(.vertical, 3)
            .padding(.horizontal, 10)
            .background(isOpen ? Color(hex: "#4CAF50") : Color(hex: "#F44336"))
            .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    HStack {
        StatusPill(isOpen: true)
        StatusPill(isOpen: false)
    }
    .padding()
}
