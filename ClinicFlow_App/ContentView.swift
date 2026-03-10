//
// ContentView.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-07.
//
import SwiftUI

indirect enum AppScreen: Equatable {
    case splash
    case login
    case signup
    case otpVerification
    case phoneVerified
    case home
    case call
    case services
    case notifications
    case map
    case appointments
    case appointmentDetail(Appointment, from: AppScreen)
    case yourTurn(Appointment)
    case qrScanner(Appointment)
    case doctorDetail(DoctorDetail, from: AppScreen)
    case bookAppointment(DoctorDetail)
    case selectPackage(DoctorDetail)
    case patientDetails(DoctorDetail)
    case consultationComplete
    case profile
}

private let mainTabs: [AppScreen] = [.home, .services, .notifications, .map, .appointments, .profile]

struct ContentView: View {
    @State private var currentScreen: AppScreen = .splash
    @State private var servicesTab: ServicesTab = .doctor

    private var showBottomNav: Bool {
        mainTabs.contains(currentScreen)
    }

    private var activeTabLabel: String {
        switch currentScreen {
        case .home:         return "Home"
        case .services:     return "Services"
        case .map:          return "Map"
        case .appointments: return "Appointments"
        case .profile:      return "Profile"
        default:            return ""
        }
    }

    var body: some View {
        VStack(spacing: 0) {

            ZStack {
                switch currentScreen {

                case .splash:
                    SplashScreen(onTap: {
                        withAnimation(.easeInOut(duration: 0.4)) { currentScreen = .login }
                    })

                case .login:
                    LoginScreen(
                        onSendOTP: {
                            withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .otpVerification }
                        },
                        onSignup: {
                            withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .signup }
                        }
                    )

                case .signup:
                    SignupScreen(
                        onBack:  { withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .login } },
                        onLogin: { withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .login } }
                    )

                case .otpVerification:
                    OTPVerificationScreen(
                        onVerified: {
                            withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .phoneVerified }
                        },
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .login }
                        }
                    )

                case .phoneVerified:
                    PhoneVerifiedScreen(
                        onContinue: {
                            withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .home }
                        }
                    )

                case .home:
                    HomeScreen(
                        onNotificationTap: {
                            withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .notifications }
                        },
                        onSeeAllDoctors:      { navigateToServices(tab: .doctor) },
                        onSeeAllLabs:         { navigateToServices(tab: .lab) },
                        onSeeAllAppointments: {
                            withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .appointments }
                        },
                        onViewAppointment: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .appointmentDetail(HomeData.currentAppointment, from: .home)
                            }
                        },
                        onCallTap: {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                currentScreen = .call
                            }
                        },
                        onDoctorTap: { doctor in
                            if let detail = DoctorDetailData.bySlug[doctor.slug] {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    currentScreen = .doctorDetail(detail, from: .home)
                                }
                            }
                        },
                        onLabTap:      { _ in navigateToServices(tab: .lab) },
                        onCategoryTap: { category in
                            switch category {
                            case .emergency: navigateToServices(tab: .doctor)
                            case .doctors:   navigateToServices(tab: .doctor)
                            case .labs:      navigateToServices(tab: .lab)
                            case .pharmacy:  navigateToServices(tab: .pharmacy)
                            }
                        }
                    )

                case .call:
                    CallScreen(
                        onEnd: {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                currentScreen = .home
                            }
                        }
                    )

                case .services:
                    ServicesScreen(
                        initialTab: servicesTab,
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .home }
                        },
                        onDoctorTap: { serviceDoctor in
                            if let detail = DoctorDetailData.bySlug[serviceDoctor.slug] {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    currentScreen = .doctorDetail(detail, from: .services)
                                }
                            }
                        },
                        onAppointment: { serviceDoctor in
                            if let detail = DoctorDetailData.bySlug[serviceDoctor.slug] {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    currentScreen = .bookAppointment(detail)
                                }
                            }
                        }
                    )

                case .notifications:
                    NotificationsScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .home }
                        }
                    )

                case .map:
                    MapScreen(onBack: {
                        withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .home }
                    })

                case .appointments:
                    AppointmentsScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .home }
                        },
                        onAppointmentTap: { appt in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .appointmentDetail(appt, from: .appointments)
                            }
                        },
                        onStartNow: { appt in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .appointmentDetail(appt, from: .appointments)
                            }
                        }
                    )

                case .appointmentDetail(let appt, let source):
                    AppointmentDetailScreen(
                        appointment: appt,
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = source
                            }
                        },
                        onYourTurn: {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                currentScreen = .yourTurn(appt)
                            }
                        }
                    )

                case .yourTurn(let appt):
                    YourTurnScreen(
                        appointment: appt,
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .appointmentDetail(appt, from: .appointments)
                            }
                        },
                        onScanQR: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .qrScanner(appt)
                            }
                        }
                    )

                case .qrScanner(let appt):
                    QRScannerScreen(
                        onCapture: {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                currentScreen = .consultationComplete
                            }
                        },
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .yourTurn(appt)
                            }
                        }
                    )

                case .doctorDetail(let doctor, let source):
                    DoctorDetailScreen(
                        doctor: doctor,
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = source
                            }
                        },
                        onBook: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .bookAppointment(doctor)
                            }
                        }
                    )

                case .bookAppointment(let doctor):
                    BookAppointmentScreen(
                        doctor: doctor,
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .doctorDetail(doctor, from: .services)
                            }
                        },
                        onMakeAppointment: { _, _ in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .selectPackage(doctor)
                            }
                        }
                    )

                case .selectPackage(let doctor):
                    SelectPackageScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .bookAppointment(doctor)
                            }
                        },
                        onNext: { _ in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .patientDetails(doctor)
                            }
                        }
                    )

                case .patientDetails(let doctor):
                    PatientDetailsScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .selectPackage(doctor)
                            }
                        },
                        onNext: { _ in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .appointments
                            }
                        }
                    )

                case .consultationComplete:
                    ConsultationCompleteScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .home
                            }
                        }
                    )

                case .profile:
                    ProfileScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .home }
                        },
                        onLogout: {
                            withAnimation(.easeInOut(duration: 0.4)) { currentScreen = .splash }
                        }
                    )
                }
            }
            .animation(.easeInOut(duration: 0.35), value: currentScreen)

            if showBottomNav {
                BottomNav(activeTab: activeTabLabel) { tab in
                    navigate(to: tab)
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }

    private func navigateToServices(tab: ServicesTab) {
        servicesTab = tab
        withAnimation(.easeInOut(duration: 0.3)) { currentScreen = .services }
    }

    private func navigate(to tab: String) {
        let target: AppScreen = switch tab {
        case "Home":         .home
        case "Services":     .services
        case "Map":          .map
        case "Appointments": .appointments
        case "Profile":      .profile
        default:             currentScreen
        }
        guard target != currentScreen else { return }
        withAnimation(.easeInOut(duration: 0.3)) { currentScreen = target }
    }
}

#Preview {
    ContentView()
}
