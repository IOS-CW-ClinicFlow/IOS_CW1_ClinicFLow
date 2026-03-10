//
//  AppointmentsData.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import Foundation

struct AppointmentsData {

    static let appointments: [Appointment] = [

        // ── Upcoming ───────────────────────────────────────────────────────
        Appointment(doctorName: "Dr. Nayanathara",
                    specialty:  "Cardio Consultation",
                    date: "Mar 25, 2026", time: "10:00 AM",
                    location: "Floor 1, Room 7",
                    bookingId: "#DR4S2SA54",
                    avatarName: "doctor_avatar",
                    status: .upcoming, remindMe: true),

        Appointment(doctorName: "Dr. Harsha Fernando",
                    specialty:  "General Medicine",
                    date: "Mar 30, 2026", time: "11:00 AM",
                    location: "Floor 2, Room 1",
                    bookingId: "#DR4S2SA54",
                    avatarName: "doctor_male",
                    status: .upcoming, remindMe: true),

        Appointment(doctorName: "Dr. Amila Herath",
                    specialty:  "Internal Medicine",
                    date: "Apr 2, 2026", time: "10:00 AM",
                    location: "Floor 3, Room 4",
                    bookingId: "#DR4S2SA54",
                    avatarName: "doctor_female",
                    status: .upcoming, remindMe: false),

        // ── Completed ──────────────────────────────────────────────────────
        Appointment(doctorName: "Dr. Jayaani Dennis",
                    specialty:  "Physiotherapy",
                    date: "Dec 25, 2025", time: "10:00 AM",
                    location: "Floor 1, Room 1",
                    bookingId: "#DR4S2SA54",
                    avatarName: "doc_jayaani",
                    status: .completed),

        Appointment(doctorName: "Dr. Sarath Fernando",
                    specialty:  "Dentistry",
                    date: "Aug 25, 2025", time: "10:00 AM",
                    location: "Floor 2, Room 5",
                    bookingId: "#DR4S2SA54",
                    avatarName: "doc_sarath",
                    status: .completed),

        Appointment(doctorName: "Dr. Ruwini Maleesha",
                    specialty:  "Dermatology",
                    date: "Apr 15, 2025", time: "10:00 AM",
                    location: "Floor 1, Room 3",
                    bookingId: "#DR4S2SA54",
                    avatarName: "doctor_female",
                    status: .completed),

        // ── Cancelled ──────────────────────────────────────────────────────
        Appointment(doctorName: "Dr. Ryan De Silva",
                    specialty:  "Cardiology",
                    date: "Jan 23, 2026", time: "07:00 PM",
                    location: "Floor 1, Room 3",
                    bookingId: "#DR4S2SA54",
                    avatarName: "doc_ryan",
                    status: .cancelled),

        Appointment(doctorName: "Dr. Ruwini Maleesha",
                    specialty:  "Dermatology",
                    date: "Dec 25, 2025", time: "10:00 AM",
                    location: "Floor 2, Room 2",
                    bookingId: "#DR4S2SA54",
                    avatarName: "doctor_female",
                    status: .cancelled),

        Appointment(doctorName: "Dr. Sarath Fernando",
                    specialty:  "Dentistry",
                    date: "Aug 25, 2025", time: "10:00 AM",
                    location: "Floor 3, Room 1",
                    bookingId: "#DR4S2SA54",
                    avatarName: "doc_sarath",
                    status: .cancelled),
    ]
}
