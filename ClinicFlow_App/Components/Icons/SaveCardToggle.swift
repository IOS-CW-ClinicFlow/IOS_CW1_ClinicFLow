//
//  SaveCardToggle.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import SwiftUI

struct SaveCardToggle: View {
    @Binding var isOn: Bool

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.15)) { isOn.toggle() }
        } label: {
            HStack(spacing: 10) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(isOn ? Color(hex: "#1A8FD1") : Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(isOn ? Color.clear : Color(hex: "#CCCCDD"), lineWidth: 1.5)
                        )
                        .frame(width: 20, height: 20)

                    if isOn {
                        Image(systemName: "checkmark")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }

                Text("Save Card")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color(hex: "#555555"))
            }
        }
        .buttonStyle(.plain)
    }
}
