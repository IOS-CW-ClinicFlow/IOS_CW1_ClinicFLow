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
        time:       "09:00 - 10:00",
        location:   "Floor 1, Room 3",
        bookingId:  "#CF00123",
        avatarName: "doctor_avatar",
        status:     .upcoming
    )

    // ─── Today's Doctors ──────────────────────────────────────────────────
    static let doctors: [Doctor] = [
        Doctor(
            name:               "Dr. Ryan De Silva",
            credentials:        "MBBS, MD Cardiology",
            rating:             4.9,
            imageName:          "doc_ryan",
            backgroundColorHex: "#D6E8F5",
            slug:               "ryan-de-silva"
        ),
        Doctor(
            name:               "Dr. Jayaani Dennis",
            credentials:        "MBBS, MSc Physiology",
            rating:             4.8,
            imageName:          "doc_jayaani",
            backgroundColorHex: "#E8E8F2",
            slug:               "jayaani-dennis"
        ),
        Doctor(
            name:               "Dr. Sarath Fernando",
            credentials:        "BDS, MDS Dentistry",
            rating:             4.7,
            imageName:          "doc_sarath",
            backgroundColorHex: "#D6F5E8",
            slug:               "sarath-fernando"
        ),
    ]

    // ─── Labs ─────────────────────────────────────────────────────────────
    static let labs: [Lab] = [
        Lab(name: "Blood Test", waitTime: "15 min", distance: "1.5km", rating: 4.8, imageName: "lab_blood",slug: "blood-test"),
        Lab(name: "MRI",        waitTime: "10 min", distance: "2.5km", rating: 4.6, imageName: "lab_mri",slug: "mri"),
    ]

    // ─── User location ────────────────────────────────────────────────────
    static let locationName = "Colombo"
}
