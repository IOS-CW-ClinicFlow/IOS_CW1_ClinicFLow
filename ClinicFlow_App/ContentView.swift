//
// ContentView.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-07.
//
//
//  ContentView.swift
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
    case emergency
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
    case payment(DoctorDetail)
    case addCard(DoctorDetail)
    case reviewSummary(ReviewSummaryInfo)
    case successScreen(SuccessInfo)
    case consultationComplete
    case profile
    case labDetail(LabDetail)
    case labPatientDetails(LabDetail, date: String, time: String)
    case labPayment(LabDetail, date: String, time: String)
    case labAddCard(LabDetail, date: String, time: String)
    case labReviewSummary(ReviewSummaryInfo)
    case pharmacyDetail(PharmacyDetail)
    case pharmacySuccess(SuccessInfo)
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
                            case .emergency:
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .emergency
                            }
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

                case .emergency:
                    EmergencyScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .home
                            }
                        },
                        onCall: { actionType in
                            withAnimation(.easeInOut(duration: 0.4)) {
                                currentScreen = .call
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
                        onLabTap: { servicePlace in
                            if let lab = LabDetailData.bySlug[servicePlace.slug] {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    currentScreen = .labDetail(lab)
                                }
                            }
                        },
                        onPharmacyTap: { servicePlace in
                            if let pharmacy = PharmacyData.bySlug[servicePlace.slug] {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    currentScreen = .pharmacyDetail(pharmacy)
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
                                currentScreen = .payment(doctor)
                            }
                        }
                    )

                case .payment(let doctor):
                    PaymentScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .patientDetails(doctor)
                            }
                        },
                        onNext: { method in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                if method == .card {
                                    currentScreen = .addCard(doctor)
                                } else {
                                    // bank or cash → skip card entry, go straight to review
                                    let info = ReviewSummaryInfo(
                                        context:       .doctor(doctor),
                                        dateAndHour:   "October 4, 2026 | 07:00 PM",
                                        packageName:   "Visiting",
                                        bookingFor:    "Self",
                                        amount:        "Rs 4,000",
                                        paymentMethod: method
                                    )
                                    currentScreen = .reviewSummary(info)
                                }
                            }
                        }
                    )

                case .addCard(let doctor):
                    AddCardScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .payment(doctor)
                            }
                        },
                        onAddCard: { _ in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                let info = ReviewSummaryInfo(
                                    context:       .doctor(doctor),
                                    dateAndHour:   "October 4, 2026 | 07:00 PM",
                                    packageName:   "Visiting",
                                    bookingFor:    "Self",
                                    amount:        "Rs 4,000",
                                    paymentMethod: .card
                                )
                                currentScreen = .reviewSummary(info)
                            }
                        }
                    )

                case .reviewSummary(let info):
                    ReviewSummaryScreen(
                        info: info,
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                switch info.paymentMethod {
                                case .card:
                                    if case .doctor(let doctor) = info.context {
                                        currentScreen = .addCard(doctor)
                                    }
                                default:
                                    if case .doctor(let doctor) = info.context {
                                        currentScreen = .payment(doctor)
                                    }
                                }
                            }
                        },
                        onPay: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                // Card → Payment Success first, then Booking Success
                                // Cash/bank → Booking Success directly
                                if info.paymentMethod == .card {
                                    let entityName: String
                                    if case .doctor(let d) = info.context { entityName = d.name }
                                    else if case .lab(let n, _) = info.context { entityName = n }
                                    else { entityName = "" }
                                    currentScreen = .successScreen(
                                        SuccessData.doctorPayment(entityName: entityName)
                                    )
                                } else {
                                    let entityName: String
                                    if case .doctor(let d) = info.context { entityName = d.name }
                                    else if case .lab(let n, _) = info.context { entityName = n }
                                    else { entityName = "" }
                                    currentScreen = .successScreen(
                                        SuccessData.doctorBooking(entityName: entityName)
                                    )
                                }
                            }
                        },
                        onChangePayment: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                if case .doctor(let doctor) = info.context {
                                    currentScreen = .payment(doctor)
                                }
                            }
                        }
                    )

                case .successScreen(let info):
                    SuccessScreen(
                        info: info,
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .home
                            }
                        },
                        onViewAppointment: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                // If this was paymentSuccess, next step is bookingSuccess
                                switch info.kind {
                                case .paymentSuccess:
                                    currentScreen = .successScreen(
                                        SuccessData.doctorBooking(entityName: info.entityName)
                                    )
                                case .labPaymentSuccess:
                                    currentScreen = .successScreen(
                                        SuccessData.labBooking(entityName: info.entityName)
                                    )
                                default:
                                    currentScreen = .appointments
                                }
                            }
                        },
                        onGoHome: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .home
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

                case .labDetail(let lab):
                    LabDetailScreen(
                        lab: lab,
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .services
                            }
                        },
                        onBook: { lab, date, time in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .labPatientDetails(lab, date: date, time: time)
                            }
                        }
                    )

                case .labPatientDetails(let lab, date: let date, time: let time):
                    PatientDetailsScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .labDetail(lab)
                            }
                        },
                        onNext: { _ in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .labPayment(lab, date: date, time: time)
                            }
                        }
                    )

                case .labPayment(let lab, date: let date, time: let time):
                    PaymentScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .labPatientDetails(lab, date: date, time: time)
                            }
                        },
                        onNext: { method in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                if method == .card {
                                    currentScreen = .labAddCard(lab, date: date, time: time)
                                } else {
                                    let info = ReviewSummaryInfo(
                                        context:       .lab(labName: lab.name, labImageName: lab.imageName),
                                        dateAndHour:   "\(date) | \(time)",
                                        packageName:   lab.name,
                                        bookingFor:    "Self",
                                        amount:        lab.serviceFee,
                                        paymentMethod: method
                                    )
                                    currentScreen = .labReviewSummary(info)
                                }
                            }
                        }
                    )

                case .labAddCard(let lab, date: let date, time: let time):
                    AddCardScreen(
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .labPayment(lab, date: date, time: time)
                            }
                        },
                        onAddCard: { _ in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                let info = ReviewSummaryInfo(
                                    context:       .lab(labName: lab.name, labImageName: lab.imageName),
                                    dateAndHour:   "\(date) | \(time)",
                                    packageName:   lab.name,
                                    bookingFor:    "Self",
                                    amount:        lab.serviceFee,
                                    paymentMethod: .card
                                )
                                currentScreen = .labReviewSummary(info)
                            }
                        }
                    )

                case .labReviewSummary(let info):
                    ReviewSummaryScreen(
                        info: info,
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                if case .lab(let name, _) = info.context {
                                    let slug = ServicesData.labs.first(where: { $0.name == name })?.slug ?? ""
                                    if let lab = LabDetailData.bySlug[slug] {
                                        switch info.paymentMethod {
                                        case .card: currentScreen = .labAddCard(lab, date: "", time: "")
                                        default:    currentScreen = .labPayment(lab, date: "", time: "")
                                        }
                                    }
                                }
                            }
                        },
                        onPay: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                let entityName: String
                                if case .lab(let n, _) = info.context { entityName = n } else { entityName = "" }
                                if info.paymentMethod == .card {
                                    currentScreen = .successScreen(SuccessData.labPayment(entityName: entityName))
                                } else {
                                    currentScreen = .successScreen(SuccessData.labBooking(entityName: entityName))
                                }
                            }
                        },
                        onChangePayment: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                if case .lab(let name, _) = info.context {
                                    let slug = ServicesData.labs.first(where: { $0.name == name })?.slug ?? ""
                                    if let lab = LabDetailData.bySlug[slug] {
                                        currentScreen = .labPayment(lab, date: "", time: "")
                                    }
                                }
                            }
                        }
                    )

                case .pharmacyDetail(let pharmacy):
                    PharmacyScreen(
                        pharmacy: pharmacy,
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .services
                            }
                        },
                        onOrder: { pharmacy in
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .pharmacySuccess(
                                    SuccessData.pharmacyOrderConfirmed(entityName: pharmacy.name)
                                )
                            }
                        }
                    )

                case .pharmacySuccess(let info):
                    SuccessScreen(
                        info: info,
                        onBack: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                currentScreen = .home
                            }
                        },
                        onViewAppointment: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                // pharmacyOrderConfirmed → pharmacyOrderComplete
                                if info.kind == .pharmacyOrderConfirmed {
                                    currentScreen = .pharmacySuccess(
                                        SuccessData.pharmacyOrderComplete()
                                    )
                                } else {
                                    currentScreen = .home
                                }
                            }
                        },
                        onGoHome: {
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
