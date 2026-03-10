//
//  LabDetailData.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import Foundation

enum LabDetailData {

    static let xRay = LabDetail(
        name:      "X - Ray",
        subtitle:  "Radiology, Skeletal",
        imageName: "lab_xray",
        location:  "Ground Floor, B-Wing",
        hours:     "Mon - Sat  |  10:00 AM - 08:00 PM",
        about:     "Our X-ray department provides fast and accurate imaging to help diagnose bone fractures, infections, and other conditions with minimal radiation exposure.",
        serviceFee: "Rs. 2,000",
        chips: [
            LabChip(label: "Certified",       colorHex: "#2196F3", iconName: "checkmark"),
            LabChip(label: "HIPAA-compliant",  colorHex: "#2196F3", iconName: "shield"),
            LabChip(label: "15-20 min",        colorHex: "#2196F3", iconName: "clock"),
            LabChip(label: "No Prep",          colorHex: "#F44336", iconName: "xmark.circle"),
            LabChip(label: "Online Results",   colorHex: "#00897B", iconName: "desktopcomputer"),
            LabChip(label: "Within 24hrs",     colorHex: "#2196F3", iconName: "clock"),
        ],
        slots: [
            LabSlot(day: "Today", date: "4 Oct"),
            LabSlot(day: "Mon",   date: "5 Oct"),
            LabSlot(day: "Tue",   date: "6 Oct"),
            LabSlot(day: "Wed",   date: "7 Oct"),
        ],
        times: ["7:00 PM", "7:30 PM", "8:00 PM", "8:30 PM"]
    )

    // Add more labs here as needed
    static let byName: [String: LabDetail] = [
        "X - Ray": xRay,
    ]
}
