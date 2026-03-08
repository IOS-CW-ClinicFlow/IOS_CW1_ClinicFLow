//
// ContentView.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

enum AppScreen {
    case splash
    case login
    case signup
    case otpVerification
    case phoneVerified
    case home
    case services
}

struct ContentView: View {
    @State private var currentScreen: AppScreen = .splash
    @State private var servicesTab: ServicesTab = .doctor

    var body: some View {
        ZStack {
            switch currentScreen {

            case .splash:
                SplashScreen(onTap: {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        currentScreen = .login
                    }
                })

            case .login:
                LoginScreen(
                    onSendOTP: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .otpVerification
                        }
                    },
                    onSignup: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .signup
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
                            currentScreen = .home
                        }
                    }
                )

            case .home:
                HomeScreen(
                    onNotificationTap: {},
                    onSeeAllDoctors: {
                        navigateToServices(tab: .doctor)
                    },
                    onSeeAllLabs: {
                        navigateToServices(tab: .lab)
                    },
                    onDoctorTap: { _ in
                        navigateToServices(tab: .doctor)
                    },
                    onLabTap: { _ in
                        navigateToServices(tab: .lab)
                    },
                    onCategoryTap: { category in
                        switch category {
                        case .emergency: navigateToServices(tab: .doctor)
                        case .doctors:   navigateToServices(tab: .doctor)
                        case .labs:      navigateToServices(tab: .lab)
                        case .pharmacy:  navigateToServices(tab: .pharmacy)
                        }
                    }
                )
                .withBottomNav(current: .home) { tab in
                    navigate(to: tab)
                }

            case .services:
                ServicesScreen(
                    initialTab: servicesTab,
                    onBack: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .home
                        }
                    }
                )
                .withBottomNav(current: .services) { tab in
                    navigate(to: tab)
                }
            }
        }
        .animation(.easeInOut(duration: 0.35), value: currentScreen)
    }

    // ── Navigate to services with a specific tab ─────────────────────────────

    private func navigateToServices(tab: ServicesTab) {
        servicesTab = tab
        withAnimation(.easeInOut(duration: 0.3)) {
            currentScreen = .services
        }
    }

    // ── Tab → screen mapping ───────────────────────────────────────────────

    private func navigate(to tab: String) {
        let target: AppScreen = switch tab {
        case "Home":     .home
        case "Services": .services
        default:         currentScreen   // other tabs not built yet
        }
        guard target != currentScreen else { return }
        withAnimation(.easeInOut(duration: 0.3)) {
            currentScreen = target
        }
    }
}

#Preview {
    ContentView()
}
