//
//  SuccessCheckIcon.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import SwiftUI

struct SuccessCheckIcon: View {
    @State private var scale: CGFloat = 0.3
    @State private var opacity: Double = 0

    var body: some View {
        ZStack {
            Circle()
                .fill(Color(hex: "#4CAF50"))
                .frame(width: 100, height: 100)
                .shadow(color: Color(hex: "#4CAF50").opacity(0.35),
                        radius: 28, x: 0, y: 8)

            Image(systemName: "checkmark")
                .font(.system(size: 44, weight: .bold))
                .foregroundStyle(.white)
        }
        .scaleEffect(scale)
        .opacity(opacity)
        .onAppear {
            withAnimation(.spring(response: 0.45, dampingFraction: 0.62)) {
                scale   = 1.0
                opacity = 1.0
            }
        }
    }
}
