//
// SignupScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//

import SwiftUI

struct SignupScreen: View {
    var onBack:  () -> Void = {}
    var onLogin: () -> Void = {}

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                SignupContent(onBack: onBack, onLogin: onLogin)
            }
        }
    }
}

// ─── MARK: Inner content ──────────────────────────────────────────────────────

private struct SignupContent: View {
    var onBack:  () -> Void
    var onLogin: () -> Void
    
    @State private var fullName = MockUser.signup.fullName
    @State private var email    = MockUser.signup.email
    @State private var phone    = MockUser.signup.phone
    
    @State private var fullNameError: String? = nil
    @State private var emailError: String? = nil
    @State private var phoneError: String? = nil
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                
                // ── Back Button ───────────────────────────────────────────────
                BackButton(action: onBack)
                
                // ── Header ────────────────────────────────────────────────────
                VStack(alignment: .leading, spacing: 6) {
                    Text("Create Account")
                        .font(.cfDisplay(size: 32, weight: .bold))
                        .foregroundColor(.cfText)
                        .kerning(-0.8)
                        .lineSpacing(1.1)
                    
                    Text("Create an account to continue!")
                        .font(.cfDisplay(size: 14, weight: .regular))
                        .foregroundColor(Color(hex: "#8e8e93"))
                        .kerning(-0.1)
                }
                .padding(.bottom, 32)
                
                // ── Form Fields ───────────────────────────────────────────────
                VStack(spacing: 18) {
                    CFInputField(label: "Full Name",  text: $fullName, keyboardType: .default, error: fullNameError)
                        .onChange(of: fullName) { _ in if fullNameError != nil { fullNameError = nil } }
                    CFInputField(label: "Email",      text: $email,    keyboardType: .emailAddress, error: emailError)
                        .onChange(of: email) { _ in if emailError != nil { emailError = nil } }
                    CFPhoneInputField(text: $phone, error: phoneError)
                        .onChange(of: phone) { _ in if phoneError != nil { phoneError = nil } }
                }
                
                // ── Register Button ───────────────────────────────────────────
                CFPrimaryButton(title: "Register", action: {
                    if validateFields() {
                        onLogin()
                    }
                })
                .padding(.top, 32)
                
                // ── Divider ───────────────────────────────────────────────────
                CFDividerLabel(label: "Or Sign Up with")
                    .padding(.vertical, 24)
                
                // ── Social Buttons ────────────────────────────────────────────
                HStack(spacing: 16) {
                    Spacer()
                    SocialButton(platform: .google)
                    SocialButton(platform: .apple)
                    Spacer()
                }
                
                // ── Login Link ────────────────────────────────────────────────
                HStack(spacing: 4) {
                    Spacer()
                    Text("Already have an account?")
                        .font(.cfDisplay(size: 13.5))
                        .foregroundColor(Color(hex: "#8e8e93"))
                        .kerning(-0.1)
                    Button(action: onLogin) {
                        Text("Login")
                            .font(.cfDisplay(size: 13.5, weight: .semibold))
                            .foregroundColor(.cfBlue)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                }
                .padding(.top, 28)
            }
            .padding(.horizontal, 28)
            .padding(.bottom, 24)
        }
    }
    
    private func validateFields() -> Bool {
        var valid = true
        
        if fullName.trimmingCharacters(in: .whitespaces).isEmpty {
            fullNameError = "Name cannot be empty"
            valid = false
        } else {
            fullNameError = nil
        }
        
        if !email.contains("@") || !email.contains(".") {
            emailError = "Invalid email address"
            valid = false
        } else {
            emailError = nil
        }
        
        let digits = phone.filter { $0.isNumber }
        if digits.isEmpty {
            phoneError = "Please enter a phone number"
            valid = false
        } else if digits.count < 6 {
            phoneError = "Phone number is too short"
            valid = false
        } else {
            phoneError = nil
        }
        
        return valid
    }
    
    
    // ─── MARK: Reusable Input Field ───────────────────────────────────────────────
    
    private struct CFInputField: View {
        let label: String
        @Binding var text: String
        var keyboardType: UIKeyboardType = .default
        var error: String? = nil              // new
        @FocusState private var focused: Bool
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.cfDisplay(size: 13.5, weight: .medium))
                    .foregroundColor(.cfText)
                    .kerning(-0.1)
                
                TextField("", text: $text)
                    .font(.cfDisplay(size: 15))
                    .foregroundColor(.cfText)
                    .kerning(-0.2)
                    .keyboardType(keyboardType)
                    .autocapitalization(keyboardType == .emailAddress ? .none : .words)
                    .focused($focused)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(Color(hex: "#fafafa"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                error != nil ? Color.cfError : (focused ? Color.cfBlue : Color.cfBorder),
                                lineWidth: 1.5
                            )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .animation(.easeInOut(duration: 0.2), value: focused)
                
                if let error = error {
                    Text(error)
                        .font(.cfDisplay(size: 11))
                        .foregroundColor(.cfError)
                        .kerning(-0.1)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 2)
                }
            }
        }
    }
    
    
    
    // ─── MARK: Primary Button ─────────────────────────────────────────────────────
    
    private struct CFPrimaryButton: View {
        let title: String
        let action: () -> Void
        @State private var pressed = false
        
        var body: some View {
            Button(action: action) {
                Text(title)
                    .font(.cfDisplay(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .kerning(-0.2)
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
    
    private struct CFDividerLabel: View {
        let label: String
        
        var body: some View {
            HStack(spacing: 14) {
                Rectangle().fill(Color.cfBorder).frame(height: 1)
                Text(label)
                    .font(.cfDisplay(size: 13))
                    .foregroundColor(Color(hex: "#8e8e93"))
                    .fixedSize()
                Rectangle().fill(Color.cfBorder).frame(height: 1)
            }
        }
    }
    
    
    // ─── MARK: Preview ────────────────────────────────────────────────────────────
    
    #Preview {
        SignupScreen()
    }
}
