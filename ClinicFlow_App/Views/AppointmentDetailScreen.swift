//
//  AppointmentDetailScreen.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

private enum TrackingState {
    case idle
    case tracking
}

struct AppointmentDetailScreen: View {

    let appointment: Appointment
    var onBack:      () -> Void = {}
    var onYourTurn:  () -> Void = {}

    @State private var trackingState: TrackingState = .idle
    @State private var secondsRemaining: Int = AppointmentsData.trackingCountdownSeconds
    @State private var timer: Timer? = nil

    private let queue = AppointmentsData.currentQueue

    var body: some View {
        VStack(spacing: 0) {

            TopBar(title: "My Appointment", showBack: true, onBack: {
                stopTimer()
                onBack()
            })

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    AppointmentDoctorRow(appointment: appointment)

                    // ── Queue cards (visible while tracking) ───────────────
                    if trackingState == .tracking {
                        HStack(spacing: 10) {
                            QueueCard(label: "Current",
                                      value: "\(queue.current)",
                                      unit: nil,
                                      isHighlighted: false)
                            QueueCard(label: "Your No.",
                                      value: "\(queue.yourNumber)",
                                      unit: nil,
                                      isHighlighted: true)
                            QueueCard(label: "Wait",
                                      value: "\(secondsRemaining)",
                                      unit: "s",
                                      isHighlighted: false)
                        }
                        .padding(.horizontal, 22)
                        .padding(.bottom, 28)
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }

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

                    Rectangle()
                        .fill(Color(hex: "#F2F2F7"))
                        .frame(height: 1)
                        .padding(.horizontal, 22)
                        .padding(.vertical, 20)

                    AppointmentInfoSection(
                        title: "Patient Info.",
                        rows: [
                            (label: "Full Name", value: AppointmentsData.currentPatient.fullName),
                            (label: "Gender",    value: AppointmentsData.currentPatient.gender),
                            (label: "Age",       value: AppointmentsData.currentPatient.age),
                            (label: "Problem",   value: AppointmentsData.currentPatient.problem),
                        ]
                    )

                    Spacer(minLength: 24)
                }
            }
            .background(Color.white)

            // ── Bottom button ──────────────────────────────────────────────
            VStack(spacing: 0) {
                Rectangle().fill(Color(hex: "#F2F2F7")).frame(height: 1)

                Button {
                    startTracking()
                } label: {
                    Text(trackingState == .idle ? "Track Appointment" : "Tracking... \(secondsRemaining)s")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(trackingState == .idle
                                    ? Color(hex: "#2196F3")
                                    : Color(hex: "#2196F3").opacity(0.6))
                        .clipShape(Capsule())
                        .shadow(color: Color(hex: "#2196F3").opacity(0.4), radius: 16, x: 0, y: 4)
                        .animation(.easeInOut, value: trackingState)
                }
                .buttonStyle(.plain)
                .disabled(trackingState == .tracking)
                .padding(.horizontal, 22)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .background(Color.white)
        }
        .background(Color.white)
        .ignoresSafeArea(edges: .bottom)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: trackingState)
    }

    // ── Timer ──────────────────────────────────────────────────────────────

    private func startTracking() {
        secondsRemaining = AppointmentsData.trackingCountdownSeconds
        withAnimation { trackingState = .tracking }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if secondsRemaining > 1 {
                secondsRemaining -= 1
            } else {
                stopTimer()
                onYourTurn()
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview {
    AppointmentDetailScreen(appointment: AppointmentsData.appointments.first!)
}
