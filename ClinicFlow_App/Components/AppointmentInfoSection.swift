//
//  AppointmentInfoSection.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

// ── Single label/value row ────────────────────────────────────────────────────

struct AppointmentInfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 13))
                .foregroundColor(Color(hex: "#AAAAAA"))
            Spacer()
            Text(value)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(hex: "#1a1a1a"))
        }
        .padding(.horizontal, 22)
        .padding(.bottom, 11)
    }
}

// ── Section with title + rows ─────────────────────────────────────────────────

struct AppointmentInfoSection: View {
    let title: String
    let rows:  [(label: String, value: String)]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(Color(hex: "#1a1a1a"))
                .padding(.horizontal, 22)
                .padding(.bottom, 14)

            ForEach(rows, id: \.label) { row in
                AppointmentInfoRow(label: row.label, value: row.value)
            }
        }
    }
}

#Preview {
    AppointmentInfoSection(
        title: "Scheduled Appointment",
        rows: [
            (label: "Date",        value: "March 25, 2026"),
            (label: "Time",        value: "10:00 AM"),
            (label: "Booking for", value: "Self"),
        ]
    )
}
