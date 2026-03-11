//
//  PaymentScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-051 on 2026-03-10.
//

import SwiftUI

struct PaymentScreen: View {

    var onBack: () -> Void = {}
    var onNext: (PaymentMethod) -> Void = { _ in }

    @State private var selected: PaymentMethod = PaymentData.defaultMethod

    var body: some View {
        VStack(spacing: 0) {

            // ── Top bar ────────────────────────────────────────────────────
            TopBar(title: "Payment Methods", showBack: true, onBack: onBack)

            // ── Scrollable body ────────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {

                    PaymentSectionCard(
                        title:    PaymentSection.cardSection.rawValue,
                        methods:  PaymentData.cardMethods,
                        selected: selected,
                        onSelect: { selected = $0 }
                    )

                    PaymentSectionCard(
                        title:    PaymentSection.otherSection.rawValue,
                        methods:  PaymentData.otherMethods,
                        selected: selected,
                        onSelect: { selected = $0 }
                    )
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 22)
            }
            .background(Color(hex: "#F4F6FB"))

            // ── Next CTA ───────────────────────────────────────────────────
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(height: 1)

                PrimaryButton(title: "Next") { onNext(selected) }
                .padding(.top, 16)
                .padding(.bottom, 32)
                .padding(.horizontal, 18)
            }
            .background(Color.white)
        }
        .background(Color(hex: "#F4F6FB"))
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    PaymentScreen()
}
