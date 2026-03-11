//
//  BankCardView.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import SwiftUI

struct BankCardView: View {
    let holderName: String
    let number:     String
    let expiry:     String

    var body: some View {
        ZStack(alignment: .topLeading) {

            // ── Gold gradient background ───────────────────────────────────
            LinearGradient(
                stops: [
                    .init(color: Color(hex: "#C8960C"), location: 0.00),
                    .init(color: Color(hex: "#E8B84B"), location: 0.30),
                    .init(color: Color(hex: "#F5D178"), location: 0.55),
                    .init(color: Color(hex: "#C8960C"), location: 0.80),
                    .init(color: Color(hex: "#A67800"), location: 1.00),
                ],
                startPoint: .topLeading,
                endPoint:   .bottomTrailing
            )
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

            // ── Radial gloss ───────────────────────────────────────────────
            RadialGradient(
                colors: [Color.white.opacity(0.18), Color.clear],
                center: .init(x: 0.8, y: 0.2),
                startRadius: 0,
                endRadius: 180
            )
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

            // ── Dark bottom strip ──────────────────────────────────────────
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color.black.opacity(0.15))
                    .frame(height: 32)
            }
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))

            // ── Card content ───────────────────────────────────────────────
            VStack(alignment: .leading, spacing: 0) {

                // Row 1 — bank + VISA
                HStack(alignment: .top) {
                    Text("PG BANK")
                        .font(.system(size: 13, weight: .heavy))
                        .foregroundStyle(.white)
                        .tracking(1)
                        .shadow(color: .black.opacity(0.3), radius: 1, x: 0, y: 1)
                    Spacer()
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("VISA")
                            .font(.system(size: 20, weight: .heavy).italic())
                            .foregroundStyle(Color.white.opacity(0.9))
                        Text("GOLD")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(Color.white.opacity(0.8))
                            .tracking(2)
                    }
                }

                Spacer()

                // Row 2 — chip + contactless
                HStack(spacing: 8) {
                    ChipView()
                    ContactlessIcon()
                }

                Spacer()

                // Row 3 — card number
                Text(number.isEmpty ? "4000  1234  1234  9010" : number)
                    .font(.system(size: 15, weight: .bold).monospaced())
                    .foregroundStyle(.white)
                    .tracking(3)
                    .shadow(color: .black.opacity(0.4), radius: 1, x: 0, y: 1)

                Spacer()

                // Row 4 — expiry + holder + VISA
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("EXPIRY")
                            .font(.system(size: 8, weight: .semibold))
                            .foregroundStyle(Color.white.opacity(0.7))
                            .tracking(0.5)
                        Text(expiry.isEmpty ? "00/00" : expiry)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    Spacer().frame(width: 24)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("CARD HOLDER NAME")
                            .font(.system(size: 8, weight: .semibold))
                            .foregroundStyle(Color.white.opacity(0.7))
                            .tracking(0.5)
                        Text(holderName.isEmpty ? "CARD HOLDER NAME" : holderName.uppercased())
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.white)
                            .lineLimit(1)
                    }
                    Spacer()
                    Text("VISA")
                        .font(.system(size: 16, weight: .heavy).italic())
                        .foregroundStyle(Color.white.opacity(0.85))
                }
            }
            .padding(.horizontal, 22)
            .padding(.top, 20)
            .padding(.bottom, 16)
        }
        .frame(height: 190)
        .shadow(color: .black.opacity(0.32), radius: 28, x: 0, y: 8)
    }
}

// ── Chip ──────────────────────────────────────────────────────────────────────

private struct ChipView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(LinearGradient(
                    colors: [Color(hex: "#D4A017"), Color(hex: "#F0C040"), Color(hex: "#D4A017")],
                    startPoint: .topLeading, endPoint: .bottomTrailing
                ))
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.white.opacity(0.4), lineWidth: 1))
                .frame(width: 38, height: 28)

            VStack(spacing: 4) {
                HStack(spacing: 4) { cell; cell }
                HStack(spacing: 4) { cell; cell }
            }
            .padding(5)
        }
    }

    private var cell: some View {
        RoundedRectangle(cornerRadius: 1)
            .fill(Color.white.opacity(0.35))
    }
}

// ── Contactless ───────────────────────────────────────────────────────────────

private struct ContactlessIcon: View {
    var body: some View {
        ZStack {
            ForEach([10.0, 16.0, 22.0], id: \.self) { size in
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(Color.white.opacity(0.7), lineWidth: 1.5)
                    .frame(width: size, height: size)
                    .rotationEffect(.degrees(-90))
            }
        }
        .frame(width: 22, height: 22)
    }
}
