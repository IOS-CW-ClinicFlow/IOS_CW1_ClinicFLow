//
//  PharmacyData.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-11.
//
import Foundation

enum PharmacyData {

    static let clinicFlow = PharmacyDetail(
        name:      "ClinicFlow Pharmacy",
        subtitle:  "Internal Drug store",
        imageName: "pharmacy_1",
        location:  "Aura Building, Ground Floor",
        hours:     "Mon - Sun  |  08:00 AM - 11:00 PM",
        about:     "Our internal drugstore offers certified professionals to ensure safe and accurate dispensing of medications, supplements, and healthcare products.",
        badges: [
            PharmacyChip(label: "Certified",       colorHex: "#2196F3", iconName: "checkmark"),
            PharmacyChip(label: "HIPAA-compliant",  colorHex: "#2196F3", iconName: "shield"),
            PharmacyChip(label: "15-20 min",        colorHex: "#2196F3", iconName: "clock"),
        ],
        phone:    "+94112345100",
        mapQuery: "ClinicFlow Pharmacy Colombo"
    )

    static let bySlug: [String: PharmacyDetail] = [
        "clinic-flow-pharmacy": clinicFlow,
    ]
}
