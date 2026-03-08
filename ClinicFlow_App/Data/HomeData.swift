//
//  HomeData.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import Foundation

enum HomeData {

    // ─── Current Appointment ──────────────────────────────────────────────
    static let currentAppointment = Appointment(
        doctorName: "Dr. Nayanathara",
        specialty:  "Cardio Consultation",
        date:       "Monday, 25 Mar",
        timeSlot:   "09:00 - 10:00",
        avatarName: "doctor_avatar"         // add to Assets.xcassets
    )

    // ─── Today's Doctors ──────────────────────────────────────────────────
    static let doctors: [Doctor] = [
        Doctor(
            name:               "Dr. Sarath Dassanayake",
            credentials:        "MBBA, CEO, WWE",
            rating:             4.3,
            imageName:          "doctor_male",
            backgroundColorHex: "#D6E8F5"
        ),
        Doctor(
            name:               "Dr. Amila Herath",
            credentials:        "MBBA, CEO",
            rating:             4.7,
            imageName:          "doctor_female",
            backgroundColorHex: "#E8E8F2"
        ),
    ]

    // ─── Labs ─────────────────────────────────────────────────────────────
    static let labs: [Lab] = [
        Lab(name: "Blood Test", waitTime: "15 min", distance: "1.5km", rating: 4.8, imageName: "lab_blood"),
        Lab(name: "MRI",        waitTime: "10 min", distance: "2.5km", rating: 4.6, imageName: "lab_mri"),
    ]

    // ─── User location ────────────────────────────────────────────────────
    static let locationName = "Colombo"
}
