// ContentView.swift
// ClinicFlow_App
// Root navigation controller — wires all screens together.

import SwiftUI

// ─── MARK: App Screens ────────────────────────────────────────────────────────

enum AppScreen {
    case splash
    case login
    case signup
    case otpVerification
    case phoneVerified
}

// ─── MARK: Content View ───────────────────────────────────────────────────────

struct ContentView: View {
    @State private var currentScreen: AppScreen = .splash

    var body: some View {
        ZStack {
            switch currentScreen {

            case .splash:
                SplashScreen()
                    .onAppear {
                        // Auto-navigate to login after 2.5 s
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                currentScreen = .login
                            }
                        }
                    }

            case .login:
                LoginScreen(
                    onSendOTP: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .otpVerification
                        }
                    }
                )

            case .signup:
                SignupScreen(
                    onBack: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .login
                        }
                    },
                    onLogin: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .login
                        }
                    }
                )

            case .otpVerification:
                OTPVerificationScreen(
                    onVerified: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .phoneVerified
                        }
                    },
                    onBack: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .login
                        }
                    }
                )

            case .phoneVerified:
                PhoneVerifiedScreen(
                    onContinue: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            // TODO: Navigate to HomeScreen once built
                            currentScreen = .login
                        }
                    }
                )
            }
        }
        // Smooth cross-fade between all screen transitions
        .animation(.easeInOut(duration: 0.35), value: currentScreen)
    }
}

// ─── MARK: Preview ────────────────────────────────────────────────────────────

#Preview {
    ContentView()
}
