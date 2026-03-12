//
//  DoctorDetailsScreen.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct DoctorDetailScreen: View {

    let doctor: DoctorDetail
    var onBack:   () -> Void = {}
    var onBook:   () -> Void = {}
    var onShare:  () -> Void = {}
    var onFave:   () -> Void = {}

    @State private var isFavourited = false
    @State private var isAboutExpanded = false

    var body: some View {
        VStack(spacing: 0) {

            // ── Top bar ────────────────────────────────────────────────────
            TopBar(
                title:         "Doctor Details",
                showBack:      true,
                showShare:     true,
                showFavourite: true,
                isFavourited:  isFavourited,
                onBack:        onBack,
                onShare:       onShare,
                onFavourite: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isFavourited.toggle()
                    }
                    onFave()
                }
            )

            // ── Scrollable body ────────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // Doctor card
                    DoctorProfileCard(doctor: doctor)
                        .padding(.bottom, 22)

                    // Stats row
                    HStack(spacing: 8) {
                        DoctorStatBubble(icon: "person.2",   value: doctor.patients,   label: "Patients")
                        DoctorStatBubble(icon: "briefcase",  value: doctor.experience, label: "Years Exp.")
                        DoctorStatBubble(icon: "star.fill",  value: doctor.rating,     label: "Rating")
                    }
                    .padding(.bottom, 24)

                    Divider()
                        .padding(.bottom, 18)

                    // About
                    Text("About")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 8)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(doctor.about)
                            .font(.system(size: 13))
                            .foregroundStyle(Color(hex: "#777777"))
                            .lineSpacing(4)
                            .lineLimit(isAboutExpanded ? nil : 2)

                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                isAboutExpanded.toggle()
                            }
                        } label: {
                            Text(isAboutExpanded ? "Show less" : "Read more")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(Color(hex: "#2196F3"))
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.bottom, 20)

                    Divider()
                        .padding(.bottom, 18)

                    // Working Hours
                    Text("Working Hours")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 14)

                    VStack(spacing: 10) {
                        ForEach(doctor.workingHours) { entry in
                            WorkingHoursRow(entry: entry)
                        }
                    }

                    Spacer(minLength: 24)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .background(Color.white)

            // ── Book Appointment CTA ───────────────────────────────────────
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(height: 1)

                PrimaryButton(title: "Book Appointment", action: onBook)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .background(Color.white)
        }
        .background(Color.white)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    DoctorDetailScreen(doctor: DoctorDetailData.sample)
}
