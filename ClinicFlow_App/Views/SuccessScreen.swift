//
//  SuccessScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import SwiftUI

struct SuccessScreen: View {

    let info:               SuccessInfo
    var onBack:             () -> Void = {}
    var onViewAppointment:  () -> Void = {}
    var onGoHome:           () -> Void = {}

    var body: some View {
        VStack(spacing: 0) {

            // ── Top bar ────────────────────────────────────────────────────
            TopBar(title: info.kind.navTitle, showBack: true, onBack: onBack)

            // ── Body ───────────────────────────────────────────────────────
            VStack(spacing: 0) {
                Spacer().frame(height: 52)

                SuccessCheckIcon()
                    .padding(.bottom, 26)

                Text(info.kind.headline)
                    .font(.system(size: 22, weight: .heavy))
                    .foregroundStyle(Color(hex: "#1a1a1a"))
                    .tracking(-0.4)
                    .padding(.bottom, 12)

                subtitleView
                    .padding(.bottom, 32)

                detailGrid
                    .padding(.horizontal, 28)
                    .padding(.bottom, 32)

                Spacer()

                Rectangle()
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(height: 1)
                    .padding(.bottom, 24)
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)

            // ── CTA buttons ────────────────────────────────────────────────
            VStack(spacing: 12) {
                Button(action: onViewAppointment) {
                    Text(info.kind.primaryButtonLabel)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color(hex: "#2196F3"))
                        .clipShape(Capsule())
                        .shadow(color: Color(hex: "#2196F3").opacity(0.38),
                                radius: 14, x: 0, y: 4)
                }
                .buttonStyle(.plain)

                if info.kind.showGoHome {
                    Button(action: onGoHome) {
                        Text("Go to Home")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(Color(hex: "#2196F3"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 22)
            .padding(.bottom, 20)
            .background(Color.white)
        }
        .background(Color.white)
    }

    // ── Subtitle ───────────────────────────────────────────────────────────

    @ViewBuilder
    private var subtitleView: some View {
        if let custom = info.subtitle {
            pharmacySubtitle(custom)
                .font(.system(size: 13))
                .foregroundStyle(Color(hex: "#999999"))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, 28)
        } else {
            // Pure Text concatenation — no VStack wrapper
            (
                Text("You have successfully booked appointment with\n")
                    .font(.system(size: 13))
                    .foregroundStyle(Color(hex: "#999999"))
                +
                Text(info.entityName)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(Color(hex: "#1a1a1a"))
            )
            .multilineTextAlignment(.center)
            .lineSpacing(4)
            .padding(.horizontal, 28)
        }
    }

    // Parses **bold** markers in pharmacy subtitles
    private func pharmacySubtitle(_ text: String) -> Text {
        var result = Text("")
        let parts  = text.components(separatedBy: "**")
        for (i, part) in parts.enumerated() {
            if i % 2 == 1 {
                result = result + Text(part)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: "#1a1a1a"))
            } else {
                result = result + Text(part)
            }
        }
        return result
    }

    // ── Detail grid ────────────────────────────────────────────────────────

    @ViewBuilder
    private var detailGrid: some View {
        let details = info.details
        if details.count == 1 {
            SuccessDetailRow(detail: details[0])
                .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            let rows = stride(from: 0, to: details.count, by: 2).map {
                Array(details[$0 ..< min($0 + 2, details.count)])
            }
            VStack(spacing: 16) {
                ForEach(Array(rows.enumerated()), id: \.offset) { _, row in
                    HStack(spacing: 0) {
                        ForEach(row) { detail in
                            SuccessDetailRow(detail: detail)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        if row.count < 2 {
                            Spacer().frame(maxWidth: .infinity)
                        }
                    }
                }
            }
        }
    }
}

// ── Previews ──────────────────────────────────────────────────────────────────

#Preview("Doctor Payment") {
    SuccessScreen(info: SuccessData.doctorPayment())
}

#Preview("Doctor Booking") {
    SuccessScreen(info: SuccessData.doctorBooking())
}

#Preview("Lab Payment") {
    SuccessScreen(info: SuccessData.labPayment())
}

#Preview("Lab Booking") {
    SuccessScreen(info: SuccessData.labBooking())
}

#Preview("Pharmacy Confirmed") {
    SuccessScreen(info: SuccessData.pharmacyOrderConfirmed())
}

#Preview("Pharmacy Complete") {
    SuccessScreen(info: SuccessData.pharmacyOrderComplete())
}
