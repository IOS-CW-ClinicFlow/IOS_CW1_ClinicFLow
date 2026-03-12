//
//  Starring.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct StarRating: View {
    var total: Int    = 5
    var filled: Int   = 4
    var rating: Double = 4.8

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<total, id: \.self) { i in
                Image(systemName: i < filled ? "star.fill" : "star")
                    .font(.system(size: 12))
                    .foregroundColor(i < filled ? Color(hex: "#FFC107") : Color(hex: "#DDDDDD"))
            }
            Text(String(format: "%.1f", rating))
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(Color(hex: "#555555"))
                .padding(.leading, 3)
        }
    }
}

#Preview {
    StarRating(filled: 4, rating: 4.8).padding()
}
