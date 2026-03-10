//
//  SelectPackageData.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import Foundation

struct SelectPackageData {
    static let packages: [ConsultationPackage] = [
        ConsultationPackage(
            id:          "report",
            label:       "Report Review",
            description: "Video call with doctor",
            price:       "Rs 500",
            duration:    "/15 mins",
            icon:        "doc.text"
        ),
        ConsultationPackage(
            id:          "voice",
            label:       "Voice Call",
            description: "Voice call with doctor",
            price:       "Rs 2000",
            duration:    "/15 mins",
            icon:        "phone"
        ),
        ConsultationPackage(
            id:          "video",
            label:       "Video Call",
            description: "Video call with doctor",
            price:       "Rs 3000",
            duration:    "/30 mins",
            icon:        "video"
        ),
        ConsultationPackage(
            id:          "visiting",
            label:       "Visiting",
            description: "Meeting up with the doctor",
            price:       "Rs 4000",
            duration:    "/30 mins",
            icon:        "person"
        ),
    ]
}
