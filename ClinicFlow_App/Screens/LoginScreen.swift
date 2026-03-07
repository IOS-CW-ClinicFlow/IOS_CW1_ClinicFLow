// LoginScreen.swift
// Clinic Flow – Login with OTP flow.
// Corresponds to: LoginScreen.tsx
//
// Usage:
//   LoginScreen(onSendOTP: { /* navigate to PhoneVerificationScreen */ })

import SwiftUI

struct LoginScreen: View {
    var onSendOTP: () -> Void

    var body: some View {
        ZStack {
            Color(hex: "#1a1a1a").ignoresSafeArea()

            PhoneShell {
                CFStatusBar()
                LoginContent(onSendOTP: onSendOTP)
                CFHomeIndicator()
            }
        }
    }
}

// ─── MARK: Inner content ──────────────────────────────────────────────────────

private struct LoginContent: View {
    var onSendOTP: () -> Void

    @State private var phone: String = "(+94 ) 76 0012 123"

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
                CFPhoneInputField(text: $phone)

                // ── Send OTP Button ───────────────────────────────────────────
                SendOTPButton(action: onSendOTP)
                    .padding(.top, 24)

                // ── Divider ───────────────────────────────────────────────────
                DividerWithLabel(label: "Or Sign In with")
                    .padding(.vertical, 22)

                // ── Social Buttons ────────────────────────────────────────────
                HStack(spacing: 16) {
                    SocialButton(imageName: "google_logo")
                    SocialButton(imageName: "apple_logo")
                }

                // ── Create Account ────────────────────────────────────────────
                HStack(spacing: 4) {
                    Text("Don't have account?")
                        .font(.cfDisplay(size: 13.5))
                        .foregroundColor(Color(hex: "#8e8e93"))
                    Text("Create Account")
                        .font(.cfDisplay(size: 13.5, weight: .semibold))
                        .foregroundColor(.cfBlue)
                }
                .padding(.top, 28)
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
        }
    }
}

// ─── MARK: Phone Input Field ──────────────────────────────────────────────────
// Mimics the react-phone-input-2 field styling.

private struct CFPhoneInputField: View {
    @Binding var text: String
    @FocusState private var focused: Bool

    var body: some View {
        HStack(spacing: 0) {
            // Country flag + code pill
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

// ─── MARK: Social Button ──────────────────────────────────────────────────────

private struct SocialButton: View {
    let imageName: String
    @State private var hovered = false

    var body: some View {
        Button(action: {}) {
            Image(imageName)                       // add to Assets.xcassets
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .frame(width: 54, height: 54)
                .background(hovered ? Color(hex: "#f0f0f5") : Color(hex: "#fafafa"))
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(
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
    LoginScreen(onSendOTP: {})
}
