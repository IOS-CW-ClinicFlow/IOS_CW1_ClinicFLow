//
//  ServiceData.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import Foundation

enum ServicesData {

    // ── Doctors ───────────────────────────────────────────────────────────
    static let doctors: [ServiceDoctor] = [
        ServiceDoctor(name: "Dr. Jayaani Dennis",  specialty: "Physiologist",  imageName: "doc_jayaani",  rating: 4.8, filledStars: 5, isFavoured: true,  slug: "jayaani-dennis"),
        ServiceDoctor(name: "Dr. Ryan De Silva",   specialty: "Cardiologist",  imageName: "doc_ryan",     rating: 4.8, filledStars: 4, isFavoured: false, slug: "ryan-de-silva"),
        ServiceDoctor(name: "Dr. Sarath Fernando", specialty: "Dentist",       imageName: "doc_sarath",   rating: 4.8, filledStars: 4, isFavoured: false, slug: "sarath-fernando"),
    ]

    // ── Labs ──────────────────────────────────────────────────────────────
    static let labs: [ServicePlace] = [
        ServicePlace(name: "X - Ray",    category: "Radiology, Skeletal",       location: "Ground Floor, B - Wing", hours: "Mon - Sat | 10:00 AM - 08:00 PM", isOpen: true,  imageName: "lab_xray",   slug: "xray"),
        ServicePlace(name: "CT Scan",    category: "Radiology, Internal Organs", location: "Ground Floor, A - Wing", hours: "Mon - Sat | 11:00 AM - 05:00 PM", isOpen: false, imageName: "lab_ct",     slug: "ct-scan"),
        ServicePlace(name: "Blood Test", category: "Hematology, General",        location: "Level 2, C - Wing",      hours: "Mon - Sun | 07:00 AM - 09:00 PM", isOpen: true,  imageName: "lab_blood",  slug: "blood-test"),
    ]

    // ── Pharmacies ────────────────────────────────────────────────────────
    static let pharmacies: [ServicePlace] = [
        ServicePlace(name: "Clinic Flow Pharmacy", category: "Internal Drugstore", location: "Aura Building, Ground Floor", hours: "Mon - Sun | 08:00 AM - 11:00 PM", isOpen: true, imageName: "pharmacy_1", slug: "clinic-flow-pharmacy"),
        ServicePlace(name: "MedPlus Pharmacy",     category: "Retail Pharmacy",    location: "Block B, Level 1",           hours: "Mon - Sat | 09:00 AM - 10:00 PM", isOpen: true, imageName: "pharmacy_2", slug: "medplus-pharmacy"),
    ]
}
