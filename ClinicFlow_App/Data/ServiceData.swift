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
        ServiceDoctor(name: "Dr. Jayaani Dennis",  specialty: "Physiologist",  imageName: "doc3",  rating: 4.8, filledStars: 5, isFavoured: true,  slug: "jayaani-dennis"),
        
        ServiceDoctor(name: "Dr. Ryan De Silva",   specialty: "Cardiologist",  imageName: "doc5",  rating: 4.8, filledStars: 4, isFavoured: false, slug: "ryan-de-silva"),
        
        ServiceDoctor(name: "Dr. Sarath Fernando", specialty: "Dentist",       imageName: "doc7",  rating: 4.8, filledStars: 4, isFavoured: false, slug: "sarath-fernando"),
        
        ServiceDoctor(name: "Dr. Amila Herath",    specialty: "Neurologist",   imageName: "doc4",  rating: 4.7, filledStars: 4, isFavoured: false, slug: "amila-herath"),
        
        ServiceDoctor(name: "Dr. Ruwini Maleesha", specialty: "Dermatologist", imageName: "doc2",  rating: 4.7, filledStars: 4, isFavoured: false, slug: "ruwini-maleesha"),

        ServiceDoctor(name: "Dr. Nayanathara",     specialty: "Cardiologist",  imageName: "doc1",  rating: 4.8, filledStars: 4, isFavoured: false, slug: "nayanathara"),

        ServiceDoctor(name: "Dr. Harsha Fernando", specialty: "General Medicine", imageName: "doc6", rating: 4.9, filledStars: 5, isFavoured: false, slug: "harsha-fernando"),
    ]
    
    // ── Labs ──────────────────────────────────────────────────────────────
    static let labs: [ServicePlace] = [
        ServicePlace(name: "X - Ray",    category: "Radiology, Skeletal",        location: "Ground Floor, B - Wing", hours: "Mon - Sat | 10:00 AM - 08:00 PM", isOpen: true,  imageName: "lab-xray1",  slug: "xray"),
        
        ServicePlace(name: "CT Scan",    category: "Radiology, Internal Organs", location: "Ground Floor, A - Wing", hours: "Mon - Sat | 11:00 AM - 05:00 PM", isOpen: false, imageName: "lab-CT2",    slug: "ct-scan"),
        
        ServicePlace(name: "Blood Test", category: "Hematology, General",        location: "Level 2, C - Wing",      hours: "Mon - Sun | 07:00 AM - 09:00 PM", isOpen: true,  imageName: "lab-blood3", slug: "blood-test"),
        
        ServicePlace(name: "MRI Scan",   category: "Radiology, Brain & Body Imaging", location: "Level 1, A - Wing", hours: "Mon - Sat | 09:00 AM - 06:00 PM", isOpen: true, imageName: "lab-MRI4", slug: "mri"),
        
        ServicePlace(name: "ECG",        category: "Cardiology, Heart Monitoring", location: "Ground Floor, Cardiac Unit", hours: "Mon - Sun | 08:00 AM - 08:00 PM", isOpen: true, imageName: "lab-ECG5", slug: "ecg"),
    ]

    // ── Pharmacies ────────────────────────────────────────────────────────
    static let pharmacies: [ServicePlace] = [
        ServicePlace(name: "Clinic Flow Pharmacy", category: "Internal Drugstore", location: "Aura Building, Ground Floor", hours: "Mon - Sun | 08:00 AM - 11:00 PM", isOpen: true, imageName: "pharmacy1", slug: "clinic-flow-pharmacy"),
    ]
}
