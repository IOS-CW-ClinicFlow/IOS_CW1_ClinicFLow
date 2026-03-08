//
//  HeartButton.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct HeartButton: View {
    @State var isFilled: Bool

    var body: some View {
        Button {
            isFilled.toggle()
        } label: {
            ZStack {
                Circle()
                    .fill(isFilled ? Color(hex: "#FFEBEE") : Color.white)
                    .frame(width: 32, height: 32)
                    .overlay(Circle().stroke(Color(hex: "#eeeeee"), lineWidth: 1))
                Image(systemName: isFilled ? "heart.fill" : "heart")
                    .font(.system(size: 13))
                    .foregroundColor(isFilled ? Color(hex: "#E53935") : Color(hex: "#CCCCCC"))
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack(spacing: 16) {
        HeartButton(isFilled: false)
        HeartButton(isFilled: true)
    }
    .padding()
}
