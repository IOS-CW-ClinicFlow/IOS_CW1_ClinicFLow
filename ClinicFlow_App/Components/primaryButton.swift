//
//  primaryButton.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-11.
//
import SwiftUI

struct PrimaryButton: View {
    let title: String
    var action: () -> Void = {}

    var body: some View {
        Button { action() } label: {
            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .background(Color(hex: "#2196F3"))
                .clipShape(Capsule())
                .shadow(color: Color(hex: "#2196F3").opacity(0.4), radius: 16, x: 0, y: 4)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PrimaryButton(title: "Book Appointment")
        .padding()
}
