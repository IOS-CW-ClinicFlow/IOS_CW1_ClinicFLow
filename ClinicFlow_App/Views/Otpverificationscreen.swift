//
// OTPVerificationScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI
import Combine

struct OTPVerificationScreen: View {
    var onVerified: () -> Void = {}
    var onBack:     () -> Void = {}

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                OTPContent(onVerified: onVerified, onBack: onBack)
            }
        }
    }
}

// ─── MARK: Inner content ──────────────────────────────────────────────────────

private struct OTPContent: View {
    var onVerified: () -> Void
    var onBack:     () -> Void

    @State private var otp         = Array(repeating: "", count: 6)
    @State private var resendTimer = 0
    @FocusState private var focusedIndex: Int?

    // Countdown timer
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {

                // ── Back Button ───────────────────────────────────────────────
                BackButton(action: onBack)

                // ── Title ─────────────────────────────────────────────────────
                Text("Phone Verification")
                    .font(.cfDisplay(size: 22, weight: .bold))
                    .foregroundColor(.cfText)
                    .kerning(-0.4)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 16)

                // ── Subtitle ──────────────────────────────────────────────────────
                Text("Enter 6 digit verification code sent to your phone number")
                    .font(.cfDisplay(size: 15))
                    .foregroundColor(Color(hex: "#555555"))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .frame(maxWidth: 280)
                    .padding(.bottom, 40)

                // ── OTP Boxes ─────────────────────────────────────────────────────
                HStack(spacing: 10) {
                    ForEach(0..<6, id: \.self) { i in
                        OTPBox(
                            digit:     $otp[i],
                            isFocused: focusedIndex == i,
                            onCommit: { handleChange(index: i) }
                        )
                        .focused($focusedIndex, equals: i)
                    }
                }
                .padding(.bottom, 36)

                // ── Resend Button ─────────────────────────────────────────────────
                Button(action: handleResend) {
                    Text(resendTimer > 0 ? "Resend Code (\(resendTimer)s)" : "Resend Code")
                        .font(.cfDisplay(size: 15, weight: .semibold))
                        .foregroundColor(resendTimer > 0 ? Color(hex: "#aaaaaa") : Color.cfBlue)
                        .animation(.easeInOut(duration: 0.2), value: resendTimer)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                .buttonStyle(.plain)
                .disabled(resendTimer > 0)
            }
            .padding(.horizontal, 28)
            .padding(.top, 16)
        }
        .onReceive(timer) { _ in
            if resendTimer > 0 { resendTimer -= 1 }
        }
        .onAppear {
            focusedIndex = 0
        }
    }

    // ── Logic ─────────────────────────────────────────────────────────────────

    private func handleChange(index: Int) {
        // Auto-advance
        if !otp[index].isEmpty && index < 5 {
            focusedIndex = index + 1
        }
        // Auto-submit when all 6 filled
        if otp.allSatisfy({ !$0.isEmpty }) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                onVerified()
            }
        }
    }

    private func handleResend() {
        otp         = Array(repeating: "", count: 6)
        resendTimer = 30
        focusedIndex = 0
    }
}

// ─── MARK: Single OTP Box ─────────────────────────────────────────────────────

private struct OTPBox: View {
    @Binding var digit: String
    let isFocused: Bool
    let onCommit:  () -> Void

    var borderColor: Color {
        !digit.isEmpty ? Color.cfBlue : Color(hex: "#d0d0d8")
    }

    var body: some View {
        TextField("", text: $digit)
            .font(.cfDisplay(size: 20, weight: .semibold))
            .foregroundColor(.cfText)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .frame(width: 44, height: 52)
            .background(Color(hex: "#fafafa"))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(borderColor, lineWidth: 1.5)
            )
            .overlay(
                // Glow ring when digit is filled
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.cfBlue.opacity(!digit.isEmpty ? 0.1 : 0), lineWidth: 6)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .animation(.easeInOut(duration: 0.2), value: digit)
            .onChange(of: digit) { newValue in
                // Keep only last digit entered
                if newValue.count > 1 {
                    digit = String(newValue.suffix(1))
                }
                // Only allow numeric input
                digit = digit.filter { $0.isNumber }
                onCommit()
            }
    }
}

// ─── MARK: Preview ────────────────────────────────────────────────────────────

#Preview {
    OTPVerificationScreen()
}
