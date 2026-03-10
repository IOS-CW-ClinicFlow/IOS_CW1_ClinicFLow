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
    case notifications
    case map
    case profile
}

// Screens that show the persistent BottomNav
private let mainTabs: [AppScreen] = [.home, .services, .notifications, .map, .profile]

struct ContentView: View {
    @State private var currentScreen: AppScreen = .splash
    @State private var servicesTab: ServicesTab = .doctor

    // Whether BottomNav should be visible
    private var showBottomNav: Bool {
        mainTabs.contains(currentScreen)
    }

    private var activeTabLabel: String {
        switch currentScreen {
        case .home:          return "Home"
        case .services:      return "Services"
        case .map:           return "Map"
        case .profile:       return "Profile"
        default:             return ""
        }
    }

    var body: some View {
        VStack(spacing: 0) {

            // ── Screen content fills all space above BottomNav ─────────────
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
                        onNotificationTap: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .notifications
                            }
                        },
                        onSeeAllDoctors: { navigateToServices(tab: .doctor) },
                        onSeeAllLabs:    { navigateToServices(tab: .lab) },
                        onDoctorTap:     { _ in navigateToServices(tab: .doctor) },
                        onLabTap:        { _ in navigateToServices(tab: .lab) },
                        onCategoryTap:   { category in
                            switch category {
                            case .emergency: navigateToServices(tab: .doctor)
                            case .doctors:   navigateToServices(tab: .doctor)
                            case .labs:      navigateToServices(tab: .lab)
                            case .pharmacy:  navigateToServices(tab: .pharmacy)
                            }
                        }
                    )

                case .services:
                    ServicesScreen(
                        initialTab: servicesTab,
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .home
                            }
                        }
                    )

                case .notifications:
                    NotificationsScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .home
                            }
                        }
                    )

                case .map:
                    MapScreen(onBack: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            currentScreen = .home
                        }
                    })

                case .profile:
                    ProfileScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .home
                            }
                        },
                        onLogout: {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                currentScreen = .splash
                            }
                        }
                    )
                }
            }
            .animation(.easeInOut(duration: 0.35), value: currentScreen)

            // ── Persistent BottomNav — only shown on main tab screens ──────
            if showBottomNav {
                BottomNav(activeTab: activeTabLabel) { tab in
                    navigate(to: tab)
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }

    // ── Navigate to services with a specific tab ───────────────────────────

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
        case "Map":      .map
        case "Profile":  .profile
        default:         currentScreen
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
