//
//  Icons.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

// ── Back Arrow ─────────────────────────────────────────────────────────────────

struct BackArrowIcon: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.cfBackground)
                .frame(width: 36, height: 36)
                .overlay(
                    Circle()
                        .stroke(Color.cfBorder, lineWidth: 1)
                )
            Image(systemName: "arrow.left")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.cfText)
        }
    }
}

// ── Check Mark ─────────────────────────────────────────────────────────────────

struct CheckIcon: View {
    var body: some View {
        Image(systemName: "checkmark")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.white)
    }
}

// ── Previews ───────────────────────────────────────────────────────────────────

#Preview("Icons") {
    HStack(spacing: 24) {
        BackArrowIcon()
        ZStack {
            Circle().fill(Color.cfBlue).frame(width: 44, height: 44)
            CheckIcon()
        }
    }
    .padding()
}
