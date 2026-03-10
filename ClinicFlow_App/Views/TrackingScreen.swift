//
//  TrackingScreen.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct TrackingScreen: View {

    let appointment: Appointment
    var onBack:    () -> Void = {}
    var onScanQR:  () -> Void = {}

    private let queue   = AppointmentsData.currentQueue
    private let patient = AppointmentsData.currentPatient

    var body: some View {
        VStack(spacing: 0) {

            // ── Top bar ────────────────────────────────────────────────────
            TopBar(title: "My Appointment", showBack: true, onBack: onBack)

            // ── Scrollable body ────────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // ── Doctor row ─────────────────────────────────────────
                    AppointmentDoctorRow(appointment: appointment)
                        .padding(.bottom, -8)   // tighten gap before queue cards

                    // ── Queue cards ────────────────────────────────────────
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
                                  value: "\(queue.waitMin)",
                                  unit: "min",
                                  isHighlighted: false)
                    }
                    .padding(.horizontal, 22)
                    .padding(.bottom, 28)

                    // ── Scheduled Appointment ──────────────────────────────
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

                    // ── Divider ────────────────────────────────────────────
                    Rectangle()
                        .fill(Color(hex: "#F2F2F7"))
                        .frame(height: 1)
                        .padding(.horizontal, 22)
                        .padding(.vertical, 20)

                    // ── Patient Info ───────────────────────────────────────
                    AppointmentInfoSection(
                        title: "Patient Info.",
                        rows: [
                            (label: "Full Name", value: patient.fullName),
                            (label: "Gender",    value: patient.gender),
                            (label: "Age",       value: patient.age),
                            (label: "Problem",   value: patient.problem),
                        ]
                    )

                    Spacer(minLength: 24)
                }
            }
            .background(Color.white)

            // ── Scan QR button ─────────────────────────────────────────────
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(height: 1)

                Button { onScanQR() } label: {
                    Text("Scan QR")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color(hex: "#2196F3"))
                        .clipShape(Capsule())
                        .shadow(color: Color(hex: "#2196F3").opacity(0.4), radius: 14, x: 0, y: 4)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 22)
                .padding(.vertical, 16)
            }
            .background(Color.white)
        }
        .background(Color.white)
    }
}

#Preview {
    TrackingScreen(appointment: AppointmentsData.appointments.first!)
}
