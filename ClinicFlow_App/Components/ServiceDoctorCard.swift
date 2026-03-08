//
//  ServiceDoctorCard.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct ServiceDoctorCard: View {
    let doctor: ServiceDoctor
    var onTap: () -> Void = {}
    var onAppointment: () -> Void = {}

    var body: some View {
        Button { onTap() } label: {
            VStack(spacing: 0) {

                // ── Top row: photo + info ──────────────────────────────────
                HStack(alignment: .top, spacing: 12) {

                    // Photo
                    ZStack {
                        Color(hex: "#D6E8F5")
                        Image(doctor.imageName)
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: 78, height: 78)
                    .clipShape(RoundedRectangle(cornerRadius: 14))

                    // Info
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            VerifiedBadge()
                            Spacer()
                            HeartButton(isFilled: doctor.isFavoured)
                        }
                        Text(doctor.name)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(hex: "#1a1a1a"))
                        Text(doctor.specialty)
                            .font(.system(size: 12))
                            .foregroundColor(Color(hex: "#999999"))
                        StarRating(filled: doctor.filledStars, rating: doctor.rating)
                    }
                }
                .padding(14)

                // ── Make Appointment button ────────────────────────────────
                Button {
                    onAppointment()
                } label: {
                    Text("Make Appointment")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(hex: "#2196F3"))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 11)
                        .background(Color(hex: "#EAF5FE"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 14)
                .padding(.bottom, 14)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.07), radius: 12, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ServiceDoctorCard(doctor: ServicesData.doctors[0])
        .padding()
}
