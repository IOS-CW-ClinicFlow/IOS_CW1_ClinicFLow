//
// LoginScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//

import SwiftUI

struct LoginScreen: View {
    var onSendOTP: () -> Void
    var onSignup: () -> Void

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                LoginContent(onSendOTP: onSendOTP, onSignup: onSignup)
            }
        }
    }
}

// ─── MARK: Inner content ──────────────────────────────────────────────────────

private struct LoginContent: View {
    var onSendOTP: () -> Void
    var onSignup: () -> Void
    
    @State private var phone: String = MockUser.loginPhone
    @State private var phoneError: String? = nil
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                
                // ── Logo ──────────────────────────────────────────────────────
                Image("clinic_flow_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                // ── Title ─────────────────────────────────────────────────────
                Text("Login to Your Account")
                    .font(.cfDisplay(size: 22, weight: .bold))
                    .foregroundColor(.cfText)
                    .kerning(-0.4)
                    .padding(.bottom, 28)
                
                // ── Phone Input ───────────────────────────────────────────────
                CFPhoneInputField(text: $phone, error: phoneError)
                    .onChange(of: phone) { _ in
                        if phoneError != nil { phoneError = nil }
                    }
                
                // ── Send OTP Button ───────────────────────────────────────────
                SendOTPButton(action: {
                    if validatePhone() {
                        onSendOTP()
                    }
                })
                .padding(.top, 24)
                
                // ── Divider ───────────────────────────────────────────────────
                DividerWithLabel(label: "Or Sign In with")
                    .padding(.vertical, 22)
                
                // ── Social Buttons ────────────────────────────────────────────
                HStack(spacing: 16) {
                    SocialButton(platform: .google)
                    SocialButton(platform: .apple)
                }
                
                // ── Create Account ────────────────────────────────────────────
                Button(action: onSignup) {
                    HStack(spacing: 4) {
                        Text("Don't have account?")
                            .font(.cfDisplay(size: 13.5))
                            .foregroundColor(Color(hex: "#8e8e93"))
                        Text("Create Account")
                            .font(.cfDisplay(size: 13.5, weight: .semibold))
                            .foregroundColor(.cfBlue)
                    }
                }
                .padding(.top, 28)
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
        }
    }
    
    private func validatePhone() -> Bool {
        let digits = phone.filter(\.isNumber)
        if digits.isEmpty {
            phoneError = "Please enter a phone number"
            return false
        } else if digits.count < 9 {
            phoneError = "Mobile number must be exactly 9 digits"
            return false
        } else if digits.count > 9 {
            phoneError = "Mobile number must not exceed 9 digits"
            return false
        }
        phoneError = nil
        return true
    }
    
    // ─── MARK: Send OTP Button ────────────────────────────────────────────────────
    
    private struct SendOTPButton: View {
        var action: () -> Void
        @State private var pressed = false
        
        var body: some View {
            Button(action: action) {
                Text("Send OTP")
                    .font(.cfDisplay(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 17)
                    .background(
                        LinearGradient(
                            colors: [Color(hex: "#2a9df4"), Color(hex: "#1a7fd4")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(Capsule())
                    .shadow(
                        color: Color.cfBlue.opacity(pressed ? 0.30 : 0.35),
                        radius: pressed ? 6 : 10,
                        x: 0, y: pressed ? 3 : 6
                    )
                    .scaleEffect(pressed ? 0.98 : 1.0)
                    .animation(.easeInOut(duration: 0.1), value: pressed)
            }
            .buttonStyle(.plain)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in pressed = true }
                    .onEnded   { _ in pressed = false }
            )
        }
    }
    
    // ─── MARK: Divider with label ─────────────────────────────────────────────────
    
    private struct DividerWithLabel: View {
        let label: String
        
        var body: some View {
            HStack(spacing: 14) {
                Rectangle()
                    .fill(Color.cfBorder)
                    .frame(height: 1)
                Text(label)
                    .font(.cfDisplay(size: 13))
                    .foregroundColor(Color(hex: "#8e8e93"))
                    .fixedSize()
                Rectangle()
                    .fill(Color.cfBorder)
                    .frame(height: 1)
            }
        }
    }
    
    
    // ─── MARK: Preview ────────────────────────────────────────────────────────────
    
    #Preview {
        LoginScreen(onSendOTP: {}, onSignup: {})
    }
}
