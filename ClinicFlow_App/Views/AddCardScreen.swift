//
//  AddCardScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import SwiftUI

struct AddCardScreen: View {

    var onBack:    () -> Void = {}
    var onAddCard: (CardForm) -> Void = { _ in }

    @State private var form = AddCardData.defaultForm

    var body: some View {
        VStack(spacing: 0) {

            // ── Top bar ────────────────────────────────────────────────────
            TopBar(title: "Add Card", showBack: true, onBack: onBack)

            // ── Scrollable body ────────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // Live card preview
                    Image("creditCard") // your asset image name
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(16)
                        .padding(.bottom, 24)
                    .padding(.bottom, 24)

                    // Card Holder Name
                    fieldLabel("Card Holder Name")
                    cardTextField("Sandun Dias", text: $form.holderName)

                    // Card Number
                    fieldLabel("Card Number")
                    cardTextField("**** **** **** ****", text: $form.number)
                        .keyboardType(.numberPad)

                    // Expiry + CVV side by side
                    HStack(spacing: 14) {
                        VStack(alignment: .leading, spacing: 0) {
                            fieldLabel("Expiry Date")
                            cardTextField("02/30", text: $form.expiry)
                                .keyboardType(.numbersAndPunctuation)
                        }
                        VStack(alignment: .leading, spacing: 0) {
                            fieldLabel("CVV")
                            cardTextField("000", text: $form.cvv, isSecure: true)
                                .keyboardType(.numberPad)
                        }
                    }

                    // Save card
                    SaveCardToggle(isOn: $form.saveCard)
                        .padding(.bottom, 24)
                }
                .padding(.horizontal, 20)
                .padding(.top, 22)
            }
            .background(Color.white)

            // ── Add Card CTA ───────────────────────────────────────────────
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(height: 1)

                PrimaryButton(title: "Add Card") { onAddCard(form) }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .background(Color.white)
        }
        .background(Color.white)
    }

    // ── Helpers ────────────────────────────────────────────────────────────

    @ViewBuilder
    private func fieldLabel(_ text: String) -> some View {
        Text(text)
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(Color(hex: "#555555"))
            .padding(.bottom, 8)
    }

    @ViewBuilder
    private func cardTextField(
        _ placeholder: String,
        text: Binding<String>,
        isSecure: Bool = false
    ) -> some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: text)
            } else {
                TextField(placeholder, text: text)
            }
        }
        .font(.system(size: 14))
        .foregroundStyle(Color(hex: "#1a1a1a"))
        .autocorrectionDisabled()
        .padding(.horizontal, 14)
        .padding(.vertical, 13)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(hex: "#E0E0EE"), lineWidth: 1.5)
        )
        .padding(.bottom, 16)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    AddCardScreen()
}
