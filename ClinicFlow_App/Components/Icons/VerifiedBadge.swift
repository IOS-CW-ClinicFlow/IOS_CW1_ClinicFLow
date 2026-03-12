//
//  VerifiedBadge.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
//
import SwiftUI

struct VerifiedBadge: View {
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 10))
                .foregroundColor(Color(hex: "#1A8FD1"))
            Text("Professional Doctor")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(Color(hex: "#1A8FD1"))
        }
        .padding(.vertical, 3)
        .padding(.horizontal, 8)
        .background(Color(hex: "#E3F2FD"))
        .clipShape(RoundedRectangle(cornerRadius: 6))
    }
}

#Preview {
    VerifiedBadge().padding()
}
