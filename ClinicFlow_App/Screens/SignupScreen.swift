// SignupScreen.swift
// Clinic Flow – Create Account screen.
// Corresponds to: Signup.tsx  (CreateAccount export)
//
// Usage:
//   SignupScreen(onBack: { /* go back */ }, onLogin: { /* go to login */ })

import SwiftUI

struct SignupScreen: View {
    var onBack:  () -> Void = {}
    var onLogin: () -> Void = {}

    var body: some View {
        ZStack {
            Color(hex: "#e5e5ea").ignoresSafeArea()

            PhoneShell {
                CFStatusBar()
                SignupContent(onBack: onBack, onLogin: onLogin)
                CFHomeIndicator()
            }
        }
    }
}

// ─── MARK: Inner content ──────────────────────────────────────────────────────

private struct SignupContent: View {
    var onBack:  () -> Void
    var onLogin: () -> Void

    @State private var fullName = "Saman Edirimuni"
    @State private var email    = "ABC@gmail.com"
    @State private var phone    = "(94) 726-0592"

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {

                // ── Back Button ───────────────────────────────────────────────
                Button(action: onBack) {
                    BackArrowIcon()
                }
                .buttonStyle(.plain)
                .padding(.top, 8)
                .padding(.bottom, 28)

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
                    CFInputField(label: "Full Name",  text: $fullName, keyboardType: .default)
                    CFInputField(label: "Email",      text: $email,    keyboardType: .emailAddress)
                    CFPhoneInputField(text: $phone)
                }

                // ── Register Button ───────────────────────────────────────────
                CFPrimaryButton(title: "Register", action: {})
                    .padding(.top, 32)

                // ── Divider ───────────────────────────────────────────────────
                CFDividerLabel(label: "Or Sign Up with")
                    .padding(.vertical, 24)

                // ── Social Buttons ────────────────────────────────────────────
                HStack(spacing: 16) {
                    Spacer()
                    CFSocialButton(imageName: "google_logo")
                    CFSocialButton(imageName: "apple_logo")
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
}

// ─── MARK: Reusable Input Field ───────────────────────────────────────────────

private struct CFInputField: View {
    let label: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    @FocusState private var focused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
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
                        .stroke(focused ? Color.cfBlue : Color.cfBorder, lineWidth: 1.5)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .animation(.easeInOut(duration: 0.2), value: focused)
        }
    }
}

// ─── MARK: Phone Input Field ──────────────────────────────────────────────────

private struct CFPhoneInputField: View {
    @Binding var text: String
    @FocusState private var focused: Bool

    var body: some View {
        HStack(spacing: 0) {
            // Country flag + code
            HStack(spacing: 6) {
                Text("🇱🇰")
                    .font(.system(size: 18))
                Text("+94")
                    .font(.cfDisplay(size: 15))
                    .foregroundColor(.cfText)
                Image(systemName: "chevron.down")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color(hex: "#8e8e93"))
            }
            .padding(.leading, 12)
            .padding(.trailing, 8)

            // Divider
            Rectangle()
                .fill(focused ? Color.cfBlue : Color.cfBorder)
                .frame(width: 1.5, height: 24)

            // Number input
            TextField("", text: $text)
                .font(.cfDisplay(size: 15))
                .foregroundColor(.cfText)
                .keyboardType(.phonePad)
                .focused($focused)
                .padding(.leading, 10)
        }
        .frame(height: 52)
        .background(Color(hex: "#fafafa"))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(focused ? Color.cfBlue : Color.cfBorder, lineWidth: 1.5)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .animation(.easeInOut(duration: 0.2), value: focused)
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

// ─── MARK: Social Button ──────────────────────────────────────────────────────

private struct CFSocialButton: View {
    let imageName: String
    @State private var hovered = false

    var body: some View {
        Button(action: {}) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .frame(width: 56, height: 56)
                .background(hovered ? Color(hex: "#f0f0f5") : Color(hex: "#fafafa"))
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(
                        hovered ? Color(hex: "#c8c8d0") : Color.cfBorder,
                        lineWidth: 1.5
                    )
                )
                .shadow(color: .black.opacity(0.06), radius: 2, x: 0, y: 1)
                .animation(.easeInOut(duration: 0.15), value: hovered)
        }
        .buttonStyle(.plain)
        .onHover { hovered = $0 }
    }
}

// ─── MARK: Preview ────────────────────────────────────────────────────────────

#Preview {
    SignupScreen()
}
