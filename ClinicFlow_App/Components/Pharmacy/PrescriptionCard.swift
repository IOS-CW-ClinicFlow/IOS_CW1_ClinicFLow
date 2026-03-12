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

    @State private var showToast   = false
    @State private var isDownloading = false

    var body: some View {
        VStack(spacing: 0) {

            // ── Header ─────────────────────────────────────────────────────
            HStack {
                Text("Prescription")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color(hex: "#1a1a1a"))

                Spacer()

                // Download button — animates on tap, shows toast
                Button {
                    guard !isDownloading else { return }
                    isDownloading = true
                    onDownload()
                    // Simulate brief download delay then show success
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        isDownloading = false
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                            showToast = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation(.easeOut(duration: 0.3)) {
                                showToast = false
                            }
                        }
                    }
                } label: {
                    ZStack {
                        Circle()
                            .fill(isDownloading
                                  ? Color(hex: "#1A8FD1").opacity(0.6)
                                  : Color(hex: "#1A8FD1"))
                            .frame(width: 32, height: 32)
                        Image(systemName: isDownloading ? "arrow.down.circle" : "arrow.down")
                            .font(.system(size: isDownloading ? 14 : 11, weight: .bold))
                            .foregroundStyle(.white)
                            .rotationEffect(.degrees(isDownloading ? 360 : 0))
                            .animation(
                                isDownloading
                                    ? .linear(duration: 0.6).repeatForever(autoreverses: false)
                                    : .default,
                                value: isDownloading
                            )
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
                    .background(Color(hex: "#1A8FD1"))
                    .clipShape(Capsule())
                    .shadow(color: Color(hex: "#1A8FD1").opacity(0.35), radius: 12, x: 0, y: 4)
            }
            .buttonStyle(.plain)
        }
        .padding(16)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color(hex: "#E8E8EE"), lineWidth: 1.5)
        )
        // ── Success toast overlaid at the top of the card ─────────────────
        .overlay(alignment: .top) {
            if showToast {
                HStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#4CAF50"))
                            .frame(width: 26, height: 26)
                        Image(systemName: "checkmark")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    Text("Prescription downloaded!")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                    Spacer()
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color(hex: "#F0FFF4"))
                        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
                )
                .padding(.horizontal, 4)
                .padding(.top, 4)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .clipped()
    }
}
