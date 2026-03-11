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
        times: ["7:00 PM", "7:30 PM", "8:00 PM", "8:30 PM"],
        phone:      "+94112345001",
        mapQuery:   "National Hospital Colombo X-Ray"
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
        times: ["9:00 AM", "10:00 AM", "11:00 AM", "2:00 PM"],
        phone:      "+94112345002",
        mapQuery:   "National Hospital Colombo CT Scan"
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
        times: ["7:00 AM", "8:00 AM", "9:00 AM", "10:00 AM"],
        phone:      "+94112345003",
        mapQuery:   "National Hospital Colombo Blood Test"
    )

    static let mri = LabDetail(
        name:       "MRI Scan",
        subtitle:   "Radiology, Soft Tissue",
        imageName:  "lab_mri",
        location:   "Level 1, A-Wing",
        hours:      "Mon - Sat  |  08:00 AM - 06:00 PM",
        about:      "Our MRI unit uses high-field magnetic resonance imaging to produce detailed images of soft tissues, joints, and the brain — with no ionising radiation.",
        serviceFee: "Rs. 6,500",
        chips: [
            LabChip(label: "Certified",      colorHex: "#2196F3", iconName: "checkmark"),
            LabChip(label: "HIPAA-compliant", colorHex: "#2196F3", iconName: "shield"),
            LabChip(label: "45-60 min",       colorHex: "#2196F3", iconName: "clock"),
            LabChip(label: "No Metal",        colorHex: "#F44336", iconName: "exclamationmark.circle"),
            LabChip(label: "Online Results",  colorHex: "#00897B", iconName: "desktopcomputer"),
            LabChip(label: "Within 24hrs",    colorHex: "#2196F3", iconName: "clock"),
        ],
        slots: [
            LabSlot(day: "Today", date: "4 Oct"),
            LabSlot(day: "Mon",   date: "5 Oct"),
            LabSlot(day: "Tue",   date: "6 Oct"),
            LabSlot(day: "Wed",   date: "7 Oct"),
        ],
        times: ["8:00 AM", "9:00 AM", "11:00 AM", "2:00 PM"],
        phone:      "+94112345004",
        mapQuery:   "National Hospital Colombo MRI"
    )

    static let ecg = LabDetail(
        name:       "ECG",
        subtitle:   "Cardiology, Cardiac Monitoring",
        imageName:  "lab_blood",
        location:   "Level 1, Cardiac Unit",
        hours:      "Mon - Sun  |  07:00 AM - 09:00 PM",
        about:      "Our ECG unit provides fast electrocardiogram recordings to detect heart rhythm abnormalities, arrhythmias, and cardiac conditions with immediate results.",
        serviceFee: "Rs. 800",
        chips: [
            LabChip(label: "Certified",      colorHex: "#2196F3", iconName: "checkmark"),
            LabChip(label: "HIPAA-compliant", colorHex: "#2196F3", iconName: "shield"),
            LabChip(label: "5-10 min",        colorHex: "#2196F3", iconName: "clock"),
            LabChip(label: "No Prep",         colorHex: "#4CAF50", iconName: "checkmark.circle"),
            LabChip(label: "Instant Results", colorHex: "#00897B", iconName: "desktopcomputer"),
            LabChip(label: "Immediate",       colorHex: "#F44336", iconName: "exclamationmark.circle"),
        ],
        slots: [
            LabSlot(day: "Today", date: "4 Oct"),
            LabSlot(day: "Mon",   date: "5 Oct"),
            LabSlot(day: "Tue",   date: "6 Oct"),
            LabSlot(day: "Wed",   date: "7 Oct"),
        ],
        times: ["7:00 AM", "8:00 AM", "9:00 AM", "10:00 AM"],
        phone:      "+94112345005",
        mapQuery:   "National Hospital Colombo ECG"
    )

    // ── Lookup by slug ─────────────────────────────────────────────────────
    static let bySlug: [String: LabDetail] = [
        "xray":       xRay,
        "ct-scan":    ctScan,
        "blood-test": bloodTest,
        "mri":        mri,
        "ecg":        ecg,
    ]
}
