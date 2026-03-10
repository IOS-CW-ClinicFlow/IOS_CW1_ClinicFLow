//
//  DoctorProfileCard.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct DoctorProfileCard: View {
    let doctor: DoctorDetail

    var body: some View {
        HStack(spacing: 14) {

            // Avatar with verified badge
            ZStack(alignment: .bottomTrailing) {
                Image(doctor.avatarName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 72, height: 72)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color(hex: "#D6E8F8"), lineWidth: 3)
                    )

                // Blue verified checkmark
                ZStack {
                    Circle()
                        .fill(Color(hex: "#2196F3"))
                        .frame(width: 20, height: 20)
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    Image(systemName: "checkmark")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundStyle(.white)
                }
                .offset(x: 2, y: 2)
            }

            // Name + specialty
            VStack(alignment: .leading, spacing: 4) {
                Text(doctor.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color(hex: "#1a1a1a"))
                Text(doctor.specialty)
                    .font(.system(size: 13))
                    .foregroundStyle(Color(hex: "#888888"))
            }

            Spacer()
        }
        .padding(16)
        .background(Color(hex: "#F8FBFF"))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(hex: "#E8F0FB"), lineWidth: 1)
        )
    }
}
