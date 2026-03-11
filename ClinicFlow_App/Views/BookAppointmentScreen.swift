//
//  BookAppointmentScreen.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct BookAppointmentScreen: View {

    let doctor: DoctorDetail
    var onBack:            () -> Void = {}
    var onMakeAppointment: (DaySlot, TimeSlot) -> Void = { _, _ in }

    @State private var selectedDay:  DaySlot  = BookAppointmentData.days.first!
    @State private var selectedTime: TimeSlot = BookAppointmentData.times.first!

    var body: some View {
        VStack(spacing: 0) {

            // ── Top bar ────────────────────────────────────────────────────
            TopBar(title: "Book Appointment", showBack: true, onBack: onBack)

            // ── Scrollable body ────────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // Doctor card
                    DoctorProfileCard(doctor: doctor)
                        .padding(.bottom, 20)

                    // Stats row
                    HStack(spacing: 8) {
                        DoctorStatBubble(icon: "person.2",  value: doctor.patients,   label: "Patients")
                        DoctorStatBubble(icon: "briefcase", value: doctor.experience, label: "Years Exp.")
                        DoctorStatBubble(icon: "star.fill", value: doctor.rating,     label: "Rating")
                    }
                    .padding(.bottom, 22)

                    Divider()
                        .padding(.bottom, 16)

                    // Section label
                    Text("BOOK APPOINTMENT")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(Color(hex: "#BBBBCC"))
                        .kerning(1.1)
                        .padding(.bottom, 16)

                    // Day picker
                    Text("Day")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 10)

                    DayPicker(days: BookAppointmentData.days, selected: $selectedDay)
                        .padding(.bottom, 20)

                    // Time picker
                    Text("Time")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 10)

                    TimePicker(times: BookAppointmentData.times, selected: $selectedTime)
                        .padding(.bottom, 20)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .background(Color.white)

            // ── Make Appointment CTA ───────────────────────────────────────
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(height: 1)

                PrimaryButton(title: "Make Appointment") {
                    onMakeAppointment(selectedDay, selectedTime)
                }
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
    BookAppointmentScreen(doctor: DoctorDetailData.sample)
}
