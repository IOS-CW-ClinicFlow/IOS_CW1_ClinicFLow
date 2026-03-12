//
//  AppointmentDoctorRow.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct AppointmentDoctorRow: View {
    let appointment: Appointment

    var body: some View {
        HStack(spacing: 14) {

            // Avatar with verified badge
            ZStack(alignment: .bottomTrailing) {
                Image(appointment.avatarName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 68, height: 68)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(hex: "#D6E8F8"), lineWidth: 3))

                ZStack {
                    Circle()
                        .fill(Color(hex: "#1A8FD1"))
                        .frame(width: 20, height: 20)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    Image(systemName: "checkmark")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.white)
                }
                .offset(x: 1, y: 1)
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(appointment.doctorName)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color(hex: "#1a1a1a"))
                Text(appointment.specialty)
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "#999999"))
            }

            Spacer()
        }
        .padding(.horizontal, 22)
        .padding(.top, 22)
        .padding(.bottom, 28)
    }
}
