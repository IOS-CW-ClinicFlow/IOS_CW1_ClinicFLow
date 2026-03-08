//
//  SocialButton.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct SocialButton: View {
    enum Platform {
        case google
        case apple

        var assetName: String {
            switch self {
            case .google: return "google_logo"      
            case .apple:  return "apple_logo"
            }
        }
    }

    let platform: Platform
    var action: () -> Void = {}

    @State private var hovered = false

    var body: some View {
        Button(action: action) {
            Image(platform.assetName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .frame(width: 56, height: 56)
                .background(hovered ? Color(hex: "#f0f0f5") : Color(hex: "#fafafa"))
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(
                        hovered ? Color(hex: "#c8c8d0") : Color.cfBorder,
                        lineWidth: 1.5
                    )
                )
                .shadow(color: .black.opacity(0.06), radius: 2, x: 0, y: 1)
                .animation(.easeInOut(duration: 0.15), value: hovered)
        }
        .buttonStyle(.plain)
        .onHover { hovered = $0 }
    }
}

// preview
#Preview {
    HStack(spacing: 16) {
        SocialButton(platform: .google)
        SocialButton(platform: .apple)
    }
}
