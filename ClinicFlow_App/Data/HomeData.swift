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
        avatarName: "doc1",
        status:     .upcoming
    )

    // ─── Today's Doctors ──────────────────────────────────────────────────
    static let doctors: [Doctor] = [
        Doctor(
            name:               "Dr. Ryan De Silva",
            credentials:        "MBBS, MD Cardiology",
            rating:             4.9,
            imageName:          "doc5.1",
            backgroundColorHex: "#D6E8F5",
            slug:               "ryan-de-silva"
        ),
        Doctor(
            name:               "Dr. Jayaani Dennis",
            credentials:        "MBBS, MSc Physiology",
            rating:             4.8,
            imageName:          "doc3.1",
            backgroundColorHex: "#E8E8F2",
            slug:               "jayaani-dennis"
        ),
        Doctor(
            name:               "Dr. Sarath Fernando",
            credentials:        "BDS, MDS Dentistry",
            rating:             4.7,
            imageName:          "doc7.1",
            backgroundColorHex: "#D6F5E8",
            slug:               "sarath-fernando"
        ),
    ]

    // ─── Labs ─────────────────────────────────────────────────────────────
    static let labs: [Lab] = [
        Lab(name: "Blood Test", waitTime: "15 min", distance: "1.5km", rating: 4.8, imageName: "lab-blood3",slug: "blood-test"),
        Lab(name: "MRI",        waitTime: "10 min", distance: "2.5km", rating: 4.6, imageName: "lab-MRI4",slug: "mri"),
    ]

    // ─── User location ────────────────────────────────────────────────────
    static let locationName = "Colombo"
}
