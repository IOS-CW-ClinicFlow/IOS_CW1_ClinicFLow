//
//  ClinicCardView.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-12.
//
import SwiftUI

struct ClinicCardView: View {
    let title: String
    let subtitle: String?
    let info: String?       // For labs (waitTime · distance)
    let imageName: String
    let backgroundHex: String
    let rating: Double
    
    var body: some View {
        VStack(spacing: 0) {
            // ── Image & Rating ─────────────────────────────
            ZStack(alignment: .bottomTrailing) {
                Color(hex: backgroundHex)
                    .frame(height: 92)
                
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 92)
                    .clipped()
                
                // Rating badge
                HStack(spacing: 3) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundColor(Color(hex: "#FFC107"))
                    Text(String(format: "%.1f", rating))
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(hex: "#333333"))
                }
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 1)
                .padding(10)
            }
            .frame(height: 92)
            .clipped()
            
            // ── Text info ─────────────────────────────
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color(hex: "#1a1a1a"))
                    .lineLimit(2)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 11))
                        .foregroundColor(Color(hex: "#AAAAAA"))
                        .lineLimit(2)
                }
                
                if let info = info {
                    HStack(spacing: 5) {
                        Circle().fill(Color(hex: "#2a9df4")).frame(width: 7, height: 7)
                        Text(info)
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: "#888888"))
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .padding(.vertical, 11)
        }
        .frame(width: 200)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.07), radius: 12, x: 0, y: 3)
    }
}

// ── Preview ─────────────────────────────
struct ClinicCardView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 20) {
            ClinicCardView(
                title: "Dr. Nayanathara",
                subtitle: "Cardio Consultation",
                info: nil,
                imageName: "doc1",
                backgroundHex: "#2ECC88",
                rating: 4.8
            )
            
            ClinicCardView(
                title: "Lab Care",
                subtitle: nil,
                info: "15 min · 2 km",
                imageName: "lab1",
                backgroundHex: "#D0E8F5",
                rating: 4.5
            )
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
