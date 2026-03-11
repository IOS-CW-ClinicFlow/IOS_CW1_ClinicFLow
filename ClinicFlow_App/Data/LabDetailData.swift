//
//  LabDetailData.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import Foundation

enum LabDetailData {

    static let xRay = LabDetail(
        name:       "X - Ray",
        subtitle:   "Radiology, Skeletal",
        imageName:  "lab_xray",
        location:   "Ground Floor, B-Wing",
        hours:      "Mon - Sat  |  10:00 AM - 08:00 PM",
        about:      "Our X-ray department provides fast and accurate imaging to help diagnose bone fractures, infections, and other conditions with minimal radiation exposure.",
        serviceFee: "Rs. 2,000",
        chips: [
            LabChip(label: "Certified",      colorHex: "#2196F3", iconName: "checkmark"),
            LabChip(label: "HIPAA-compliant", colorHex: "#2196F3", iconName: "shield"),
            LabChip(label: "15-20 min",       colorHex: "#2196F3", iconName: "clock"),
            LabChip(label: "No Prep",         colorHex: "#F44336", iconName: "xmark.circle"),
            LabChip(label: "Online Results",  colorHex: "#00897B", iconName: "desktopcomputer"),
            LabChip(label: "Within 24hrs",    colorHex: "#2196F3", iconName: "clock"),
        ],
        slots: [
            LabSlot(day: "Today", date: "4 Oct"),
            LabSlot(day: "Mon",   date: "5 Oct"),
            LabSlot(day: "Tue",   date: "6 Oct"),
            LabSlot(day: "Wed",   date: "7 Oct"),
        ],
        times: ["7:00 PM", "7:30 PM", "8:00 PM", "8:30 PM"]
    )

    static let ctScan = LabDetail(
        name:       "CT Scan",
        subtitle:   "Radiology, Internal Organs",
        imageName:  "lab_ct",
        location:   "Ground Floor, A-Wing",
        hours:      "Mon - Sat  |  11:00 AM - 05:00 PM",
        about:      "Our CT scan unit delivers detailed cross-sectional images of internal organs, helping physicians detect tumours, injuries, and vascular conditions with precision.",
        serviceFee: "Rs. 4,500",
        chips: [
            LabChip(label: "Certified",      colorHex: "#2196F3", iconName: "checkmark"),
            LabChip(label: "HIPAA-compliant", colorHex: "#2196F3", iconName: "shield"),
            LabChip(label: "30-45 min",       colorHex: "#2196F3", iconName: "clock"),
            LabChip(label: "Prep Required",   colorHex: "#F44336", iconName: "exclamationmark.circle"),
            LabChip(label: "Online Results",  colorHex: "#00897B", iconName: "desktopcomputer"),
            LabChip(label: "Within 48hrs",    colorHex: "#2196F3", iconName: "clock"),
        ],
        slots: [
            LabSlot(day: "Today", date: "4 Oct"),
            LabSlot(day: "Mon",   date: "5 Oct"),
            LabSlot(day: "Tue",   date: "6 Oct"),
            LabSlot(day: "Wed",   date: "7 Oct"),
        ],
        times: ["9:00 AM", "10:00 AM", "11:00 AM", "2:00 PM"]
    )

    static let bloodTest = LabDetail(
        name:       "Blood Test",
        subtitle:   "Hematology, General",
        imageName:  "lab_blood",
        location:   "Level 2, C-Wing",
        hours:      "Mon - Sun  |  07:00 AM - 09:00 PM",
        about:      "Our haematology lab offers a full range of blood panels — from CBC and lipid profiles to glucose and thyroid function — with rapid turnaround times.",
        serviceFee: "Rs. 1,200",
        chips: [
            LabChip(label: "Certified",      colorHex: "#2196F3", iconName: "checkmark"),
            LabChip(label: "HIPAA-compliant", colorHex: "#2196F3", iconName: "shield"),
            LabChip(label: "10-15 min",       colorHex: "#2196F3", iconName: "clock"),
            LabChip(label: "Fasting Req.",    colorHex: "#F44336", iconName: "exclamationmark.circle"),
            LabChip(label: "Online Results",  colorHex: "#00897B", iconName: "desktopcomputer"),
            LabChip(label: "Within 6hrs",     colorHex: "#2196F3", iconName: "clock"),
        ],
        slots: [
            LabSlot(day: "Today", date: "4 Oct"),
            LabSlot(day: "Mon",   date: "5 Oct"),
            LabSlot(day: "Tue",   date: "6 Oct"),
            LabSlot(day: "Wed",   date: "7 Oct"),
        ],
        times: ["7:00 AM", "8:00 AM", "9:00 AM", "10:00 AM"]
    )

    // ── Lookup by slug (matches ServicePlace.slug in ServicesData) ─────────
    static let bySlug: [String: LabDetail] = [
        "xray":       xRay,
        "ct-scan":    ctScan,
        "blood-test": bloodTest,
    ]
}
