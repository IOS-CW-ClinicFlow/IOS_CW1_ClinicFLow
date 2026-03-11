//
//  ReviewSummaryScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//

import SwiftUI

struct ReviewSummaryScreen: View {

    let info:            ReviewSummaryInfo
    var onBack:          () -> Void = {}
    var onPay:           () -> Void = {}
    var onChangePayment: () -> Void = {}

    var body: some View {
        VStack(spacing: 0) {

            // ── Top bar ────────────────────────────────────────────────────
            TopBar(title: "Review Summary", showBack: true, onBack: onBack)

            // ── Scrollable body ────────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // Doctor / lab header card
                    SummaryHeaderCard(context: info.context)
                        .padding(.bottom, 24)

                    // Booking details rows
                    SummaryRow(label: "Date & Hour", value: info.dateAndHour)
                    SummaryRow(label: "Package",     value: info.packageName)
                    SummaryRow(label: "Booking for", value: info.bookingFor)

                    Spacer().frame(height: 6)

                    SummaryRow(label: "Amount", value: info.amount)

                    // Disclaimer
                    Text("*Please note that this is the consultation fee only")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color(hex: "#F44336"))
                        .padding(.top, 2)
                        .padding(.bottom, 16)

                    // Divider
                    Rectangle()
                        .fill(Color(hex: "#F2F2F7"))
                        .frame(height: 1)
                        .padding(.bottom, 16)

                    // Total row
                    HStack {
                        Text("Total")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(Color(hex: "#1a1a1a"))
                        Spacer()
                        Text(info.amount)
                            .font(.system(size: 15, weight: .heavy))
                            .foregroundStyle(Color(hex: "#1a1a1a"))
                    }
                    .padding(.bottom, 22)

                    // Payment method row
                    PaymentMethodRow(
                        method:   info.paymentMethod,
                        onChange: onChangePayment
                    )
                    .padding(.bottom, 8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 24)
            }
            .background(Color.white)

            // ── CTA — "Pay Now" for card, "Confirm Booking" for cash/bank ──
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(height: 1)

                PrimaryButton(title: "Confirm & Pay", action: onPay)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .background(Color.white)
        }
        .background(Color.white)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ReviewSummaryScreen(
        info: ReviewSummaryData.doctorPreview(
            for: DoctorDetailData.bySlug["ryan-de-silva"]!
        )
    )
}
