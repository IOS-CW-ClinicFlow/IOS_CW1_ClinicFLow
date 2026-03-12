//
//  DoctorStatBubble.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct DoctorStatBubble: View {
    let icon:  String   // SF Symbol name
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(Color(hex: "#EAF4FE"))
                    .frame(width: 52, height: 52)
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(Color(hex: "#1A8FD1"))
            }
            Text(value)
                .font(.system(size: 13, weight: .heavy))
                .foregroundStyle(Color(hex: "#1A8FD1"))
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color(hex: "#AAAAAA"))
        }
        .frame(maxWidth: .infinity)
    }
}
