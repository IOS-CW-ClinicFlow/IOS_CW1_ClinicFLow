//
//  DoctorDetailData.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import Foundation

struct DoctorDetailData {

    // ── Full roster keyed by slug (matches ServicesData slugs) ────────────
    static let bySlug: [String: DoctorDetail] = {
        let all: [(String, DoctorDetail)] = [
            ("ryan-de-silva", DoctorDetail(
                name:       "Dr. Ryan De Silva",
                specialty:  "Cardiologist",
                avatarName: "doc_ryan",
                patients:   "7,500+",
                experience: "10+",
                rating:     "4.9+",
                about:      "Experienced cardiologist practising for over 10 years, specialising in heart disease prevention and treatment.",
                workingHours: [
                    WorkingHours(day: "Monday",  hours: "09:00 - 17:00"),
                    WorkingHours(day: "Tuesday", hours: "09:00 - 17:00"),
                    WorkingHours(day: "Sunday",  hours: "10:00 - 14:00"),
                ]
            )),
            ("jayaani-dennis", DoctorDetail(
                name:       "Dr. Jayaani Dennis",
                specialty:  "Physiologist",
                avatarName: "doc3",
                patients:   "5,200+",
                experience: "8+",
                rating:     "4.8+",
                about:      "Specialist in physiological rehabilitation and sports medicine with over 8 years of clinical experience.",
                workingHours: [
                    WorkingHours(day: "Monday",    hours: "08:00 - 16:00"),
                    WorkingHours(day: "Wednesday", hours: "08:00 - 16:00"),
                    WorkingHours(day: "Friday",    hours: "08:00 - 13:00"),
                ]
            )),
            ("sarath-fernando", DoctorDetail(
                name:       "Dr. Sarath Fernando",
                specialty:  "Dentist",
                avatarName: "doc_sarath",
                patients:   "3,800+",
                experience: "12+",
                rating:     "4.7+",
                about:      "Senior dental surgeon with 12 years of experience in general and cosmetic dentistry.",
                workingHours: [
                    WorkingHours(day: "Tuesday",  hours: "10:00 - 18:00"),
                    WorkingHours(day: "Thursday", hours: "10:00 - 18:00"),
                    WorkingHours(day: "Saturday", hours: "09:00 - 14:00"),
                ]
            )),
            ("amila-herath", DoctorDetail(
                name:       "Dr. Amila Herath",
                specialty:  "Neurologist",
                avatarName: "doc_mal",
                patients:   "6,100+",
                experience: "9+",
                rating:     "4.8+",
                about:      "Neurologist specialising in brain and nervous system disorders with nearly a decade of experience in clinical neurology.",
                workingHours: [
                    WorkingHours(day: "Monday",    hours: "09:00 - 15:00"),
                    WorkingHours(day: "Wednesday", hours: "09:00 - 15:00"),
                    WorkingHours(day: "Friday",    hours: "09:00 - 13:00"),
                ]
            )),

            ("ruwini-maleesha", DoctorDetail(
                name:       "Dr. Ruwini Maleesha",
                specialty:  "Dermatologist",
                avatarName: "doc_ruwini",
                patients:   "4,900+",
                experience: "7+",
                rating:     "4.7+",
                about:      "Dermatologist focused on skin health, acne treatment, and cosmetic dermatology with 7 years of experience.",
                workingHours: [
                    WorkingHours(day: "Tuesday",  hours: "10:00 - 17:00"),
                    WorkingHours(day: "Thursday", hours: "10:00 - 17:00"),
                    WorkingHours(day: "Saturday", hours: "09:00 - 13:00"),
                ]
            )),
        ]
        return Dictionary(uniqueKeysWithValues: all)
    }()

    // Fallback used in previews
    static let sample = bySlug["ryan-de-silva"]!
}
