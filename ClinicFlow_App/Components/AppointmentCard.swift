//
//  AppointmentCard.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct AppointmentCard: View {
    let appointment: Appointment
    var remindMe: Bool = false
    var onRemindToggle: () -> Void = {}
    var onCancel:       () -> Void = {}
    var onStartNow:     () -> Void = {}
    var onReschedule:   () -> Void = {}
    var onReBook:       () -> Void = {}
    var onView:         () -> Void = {}

    // First upcoming card gets "Start Now", rest get "Reschedule"
    var isFirstUpcoming: Bool = false

    @State private var showCancelConfirm = false

    var body: some View {
        VStack(spacing: 0) {

            // ── Date / time header ─────────────────────────────────────────
            HStack {
                Text("\(appointment.date) - \(appointment.time)")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color(hex: "#1a1a1a"))

                Spacer()

                // Remind me toggle (upcoming only)
                if appointment.status == .upcoming {
                    HStack(spacing: 6) {
                        Text("Remind me")
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: "#888888"))
                        RemindToggle(isOn: remindMe, onToggle: onRemindToggle)
                    }
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 11)

            Rectangle().fill(Color(hex: "#F2F2F7")).frame(height: 1)

            // ── Doctor info ────────────────────────────────────────────────
            HStack(spacing: 12) {

                // Avatar
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(hex: "#E8F0F8"))
                        .frame(width: 64, height: 64)
                    Image(appointment.avatarName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(appointment.doctorName)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(hex: "#1a1a1a"))

                    // Location
                    HStack(spacing: 5) {
                        Image(systemName: "mappin.fill")
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: "#888888"))
                        Text(appointment.location)
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: "#888888"))
                    }

                    // Booking ID
                    HStack(spacing: 5) {
                        Image(systemName: "doc.text")
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: "#888888"))
                        Text("Booking ID : ")
                            .font(.system(size: 11))
                            .foregroundColor(Color(hex: "#888888"))
                        Text(appointment.bookingId)
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(Color(hex: "#2196F3"))
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)

            // ── Action buttons ─────────────────────────────────────────────
            HStack(spacing: 10) {
                switch appointment.status {
                case .upcoming:
                    // Cancel (outline)
                    outlineButton(label: "Cancel", action: { showCancelConfirm = true })
                    // Start Now (green) or Reschedule (blue)
                    if isFirstUpcoming {
                        gradientButton(label: "Start Now", action: onStartNow)
                    } else {
                        solidButton(label: "Reschedule", color: Color(hex: "#2196F3"), action: onReschedule)
                    }

                case .completed:
                    outlineButton(label: "Re-Book",
                                  borderColor: Color(hex: "#2196F3"),
                                  textColor: Color(hex: "#2196F3"),
                                  action: onReBook)
                    solidButton(label: "View", color: Color(hex: "#2196F3"), action: onView)

                case .cancelled:
                    solidButton(label: "Reschedule", color: Color(hex: "#2196F3"), action: onReschedule)
                }
            }
            .padding(.horizontal, 14)
            .padding(.bottom, 14)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.07), radius: 12, x: 0, y: 2)
        .confirmationDialog(
            "Cancel Appointment",
            isPresented: $showCancelConfirm,
            titleVisibility: .visible
        ) {
            Button("Yes, Cancel Appointment", role: .destructive) { onCancel() }
            Button("Keep Appointment", role: .cancel) {}
        } message: {
            Text("Are you sure you want to cancel your appointment with \(appointment.doctorName)?")
        }
    }

    // ── Button helpers ─────────────────────────────────────────────────────

    private func outlineButton(label: String,
                                borderColor: Color = Color(hex: "#CCCCCC"),
                                textColor: Color = Color(hex: "#555555"),
                                action: @escaping () -> Void) -> some View {
        Button { action() } label: {
            Text(label)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 11)
                .background(Color.white)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(borderColor, lineWidth: 1.5))
        }
        .buttonStyle(.plain)
    }

    private func solidButton(label: String, color: Color, action: @escaping () -> Void) -> some View {
        Button { action() } label: {
            Text(label)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 11)
                .background(color)
                .clipShape(Capsule())
                .shadow(color: color.opacity(0.3), radius: 10, x: 0, y: 3)
        }
        .buttonStyle(.plain)
    }

    private func gradientButton(label: String, action: @escaping () -> Void) -> some View {
        Button { action() } label: {
            Text(label)
                .font(.system(size: 13, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 11)
                .background(
                    LinearGradient(colors: [Color(hex: "#2DC98A"), Color(hex: "#18B870")],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .clipShape(Capsule())
                .shadow(color: Color(hex: "#18B870").opacity(0.3), radius: 10, x: 0, y: 3)
        }
        .buttonStyle(.plain)
    }
}

// ── Remind Me Toggle ──────────────────────────────────────────────────────────

struct RemindToggle: View {
    let isOn: Bool
    var onToggle: () -> Void = {}

    var body: some View {
        ZStack(alignment: isOn ? .trailing : .leading) {
            Capsule()
                .fill(isOn ? Color(hex: "#2196F3") : Color(hex: "#DDDDDD"))
                .frame(width: 38, height: 22)
            Circle()
                .fill(Color.white)
                .frame(width: 16, height: 16)
                .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 1)
                .padding(3)
        }
        .onTapGesture { onToggle() }
        .animation(.spring(response: 0.25, dampingFraction: 0.8), value: isOn)
    }
}
