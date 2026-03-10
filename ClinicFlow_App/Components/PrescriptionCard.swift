//
//  PrescriptionCard.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct PrescriptionCard: View {
    let prescriptions: [Prescription]
    var onGoPharmacy: () -> Void = {}
    var onDownload:   () -> Void = {}

    var body: some View {
        VStack(spacing: 0) {

            // ── Header ─────────────────────────────────────────────────────
            HStack {
                Text("Prescription")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color(hex: "#1a1a1a"))

                Spacer()

                // Download prescription button
                Button { onDownload() } label: {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#2196F3"))
                            .frame(width: 26, height: 26)
                        Image(systemName: "arrow.down")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                .buttonStyle(.plain)
            }
            .padding(.bottom, 16)

            // ── Drug rows ──────────────────────────────────────────────────
            VStack(spacing: 12) {
                ForEach(prescriptions) { drug in
                    HStack {
                        Text(drug.name)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(Color(hex: "#444444"))
                        Spacer()
                        Text(drug.dose)
                            .font(.system(size: 13))
                            .foregroundStyle(Color(hex: "#888888"))
                    }
                }
            }
            .padding(.bottom, 16)

            // ── Go to Pharmacy button ──────────────────────────────────────
            Button { onGoPharmacy() } label: {
                Text("Go to Pharmacy")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(Color(hex: "#2196F3"))
                    .clipShape(Capsule())
                    .shadow(color: Color(hex: "#2196F3").opacity(0.35), radius: 12, x: 0, y: 4)
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color(hex: "#E8E8EE"), lineWidth: 1.5)
        )
    }
}
