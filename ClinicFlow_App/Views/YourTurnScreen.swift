//
//  YourTurnScreen.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct YourTurnScreen: View {

    let appointment: Appointment
    var onBack:   () -> Void = {}
    var onScanQR: () -> Void = {}

    @State private var showScanQR = false
    @State private var pulse      = false

    private let queue = AppointmentsData.currentQueue

    var body: some View {
        VStack(spacing: 0) {

            TopBar(title: "My Appointment", showBack: true, onBack: onBack)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    AppointmentDoctorRow(appointment: appointment)

                    // ── Your Turn banner ───────────────────────────────────
                    VStack(spacing: 20) {

                        // Pulsing icon
                        ZStack {
                            Circle()
                                .fill(Color(hex: "#2ECC88").opacity(0.15))
                                .frame(width: pulse ? 110 : 90, height: pulse ? 110 : 90)
                                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true),
                                           value: pulse)
                            Circle()
                                .fill(Color(hex: "#2ECC88").opacity(0.25))
                                .frame(width: pulse ? 82 : 70, height: pulse ? 82 : 70)
                                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true)
                                    .delay(0.15), value: pulse)
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "#2ECC88"))
                                    .frame(width: 60, height: 60)
                                Image(systemName: "bell.badge.fill")
                                    .font(.system(size: 26, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 8)

                        // Text
                        VStack(spacing: 8) {
                            Text("It's Your Turn!")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(Color(hex: "#1a1a1a"))
                            Text("Please proceed to \(appointment.location)")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#888888"))
                                .multilineTextAlignment(.center)
                        }

                        // Queue cards
                        HStack(spacing: 10) {
                            QueueCard(label: "Current",
                                      value: "\(queue.yourNumber)",
                                      unit: nil,
                                      isHighlighted: true)
                            QueueCard(label: "Your No.",
                                      value: "\(queue.yourNumber)",
                                      unit: nil,
                                      isHighlighted: true)
                            QueueCard(label: "Wait",
                                      value: "Now",
                                      unit: nil,
                                      isHighlighted: true)
                        }
                        .padding(.horizontal, 22)
                        .padding(.top, 8)
                    }
                    .padding(.bottom, 32)

                    Rectangle()
                        .fill(Color(hex: "#F2F2F7"))
                        .frame(height: 1)
                        .padding(.horizontal, 22)
                        .padding(.vertical, 20)

                    AppointmentInfoSection(
                        title: "Scheduled Appointment",
                        rows: [
                            (label: "Date",        value: appointment.date),
                            (label: "Time",        value: appointment.time),
                            (label: "Location",    value: appointment.location),
                            (label: "Booking ID",  value: appointment.bookingId),
                            (label: "Booking for", value: "Self"),
                        ]
                    )

                    Spacer(minLength: 24)
                }
            }
            .background(Color.white)

            // ── Bottom button ──────────────────────────────────────────────
            VStack(spacing: 16) {
                Rectangle().fill(Color(hex: "#F2F2F7")).frame(height: 1)

                if showScanQR {
                    PrimaryButton(title: "Scan QR") {
                        onScanQR()
                    }
                    .transition(.scale(scale: 0.85).combined(with: .opacity))
                } else {
                    // Greyed placeholder — keeps layout stable
                    HStack(spacing: 8) {
                        Image(systemName: "qrcode.viewfinder")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Scan QR")
                            .font(.system(size: 15, weight: .bold))
                    }
                    .foregroundColor(.white.opacity(0.5))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color(hex: "#2196F3").opacity(0.35))
                    .clipShape(Capsule())
                    .transition(.opacity)
                }
            }
            .padding(.horizontal, 22)
            .padding(.top, 16)
            .padding(.bottom, 32)
            .background(Color.white)
            .animation(.spring(response: 0.4, dampingFraction: 0.75), value: showScanQR)
        }
        .background(Color.white)
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            pulse = true
            DispatchQueue.main.asyncAfter(deadline: .now() + AppointmentsData.scanQRDelaySeconds) {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                    showScanQR = true
                }
            }
        }
    }
}

#Preview {
    YourTurnScreen(appointment: AppointmentsData.appointments.first!)
}
