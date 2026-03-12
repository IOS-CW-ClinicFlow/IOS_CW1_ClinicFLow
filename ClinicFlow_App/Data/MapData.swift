////
////  MapData.swift
////  ClinicFlow_App
////
////  Created by COBSCCOMP24.2P-019 on 2026-03-09.
////
//import SwiftUI
//
//struct MapData {
//
//    // "You are here" position — ratios relative to the floor plan image
//    static let currentPosition = CGPoint(x: 0.50, y: 0.55)
//
//    // Aspect ratio of the MapFloor1 asset (height ÷ width)
//    static let imageAspectRatio: CGFloat = 1.75
//
//    static let pins: [MapPin] = [
//        MapPin(xRatio: 0.25, yRatio: 0.17,
//               color: Color(hex: "#4CAF50"), hasDot: false, pulsing: false,
//               label: "Sharing Room",   distance: "50m",  time: "1 min"),
//
//        MapPin(xRatio: 0.56, yRatio: 0.14,
//               color: Color(hex: "#2196F3"), hasDot: true, pulsing: false,
//               label: "Special Ward-1", distance: "120m", time: "2 min"),
//
//        MapPin(xRatio: 0.20, yRatio: 0.35,
//               color: Color(hex: "#F44336"), hasDot: true, pulsing: false,
//               label: "Doctor Room",    distance: "80m",  time: "1 min"),
//
//        MapPin(xRatio: 0.52, yRatio: 0.33,
//               color: Color(hex: "#2196F3"), hasDot: true, pulsing: true,
//               label: "Waiting Hall",   distance: "200m", time: "3 min"),
//
//        MapPin(xRatio: 0.82, yRatio: 0.38,
//               color: Color(hex: "#2196F3"), hasDot: true, pulsing: false,
//               label: "Special Ward-2", distance: "160m", time: "2 min"),
//    ]
//}

//
//  MapData.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-09.
//
import SwiftUI

struct MapData {

    // "You are here" — centre of Waiting Hall
    static let currentPosition = CGPoint(x: 0.50, y: 0.52)

    // Image aspect ratio (height ÷ width) — MapFloor1 is portrait ~1.47
    static let imageAspectRatio: CGFloat = 1.47

    // ── Pin colours by zone ───────────────────────────────────────────────
    // Blue   → wards / patient rooms
    // Green  → admin / services
    // Red    → urgent / emergency
    // Purple → diagnostic
    // Grey   → facilities

    static let pins: [MapPin] = [

        // ── Top row ───────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.13,
               color: Color(hex: "#4CAF50"), hasDot: false, pulsing: false,
               label: "Reception",    distance: "180m", time: "3 min"),

        MapPin(xRatio: 0.50, yRatio: 0.11,
               color: Color(hex: "#4CAF50"), hasDot: false, pulsing: false,
               label: "Registration", distance: "200m", time: "3 min"),

        MapPin(xRatio: 0.82, yRatio: 0.13,
               color: Color(hex: "#9C27B0"), hasDot: true, pulsing: false,
               label: "Laboratory",   distance: "210m", time: "4 min"),

        // ── Second row ────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.28,
               color: Color(hex: "#2196F3"), hasDot: true, pulsing: false,
               label: "Sharing Room",   distance: "120m", time: "2 min"),

        MapPin(xRatio: 0.82, yRatio: 0.28,
               color: Color(hex: "#2196F3"), hasDot: true, pulsing: false,
               label: "Special Ward-1", distance: "150m", time: "2 min"),

        // ── Third row ─────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.41,
               color: Color(hex: "#F44336"), hasDot: true, pulsing: false,
               label: "Doctor Room",  distance: "80m",  time: "1 min"),

        MapPin(xRatio: 0.50, yRatio: 0.46,
               color: Color(hex: "#FF9800"), hasDot: true, pulsing: true,
               label: "Waiting Hall", distance: "0m",   time: "You are here"),

        MapPin(xRatio: 0.82, yRatio: 0.41,
               color: Color(hex: "#9C27B0"), hasDot: true, pulsing: false,
               label: "X-Ray Room",   distance: "160m", time: "2 min"),

        // ── Fourth row ────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.55,
               color: Color(hex: "#2196F3"), hasDot: false, pulsing: false,
               label: "Consultation Room", distance: "60m",  time: "1 min"),

        MapPin(xRatio: 0.82, yRatio: 0.55,
               color: Color(hex: "#2196F3"), hasDot: true, pulsing: false,
               label: "Special Ward-2",    distance: "170m", time: "3 min"),

        // ── Fifth row ─────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.68,
               color: Color(hex: "#F44336"), hasDot: true, pulsing: false,
               label: "Emergency Room", distance: "90m",  time: "1 min"),

        MapPin(xRatio: 0.82, yRatio: 0.68,
               color: Color(hex: "#F44336"), hasDot: true, pulsing: false,
               label: "ICU",            distance: "200m", time: "3 min"),

        // ── Sixth row ─────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.80,
               color: Color(hex: "#4CAF50"), hasDot: false, pulsing: false,
               label: "Nurse Station", distance: "100m", time: "2 min"),

        MapPin(xRatio: 0.50, yRatio: 0.82,
               color: Color(hex: "#4CAF50"), hasDot: false, pulsing: false,
               label: "Pharmacy",      distance: "130m", time: "2 min"),

        MapPin(xRatio: 0.82, yRatio: 0.80,
               color: Color(hex: "#9C27B0"), hasDot: true, pulsing: false,
               label: "CT Scan",       distance: "220m", time: "4 min"),

        // ── Bottom row ────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.91,
               color: Color(hex: "#607D8B"), hasDot: false, pulsing: false,
               label: "Washrooms", distance: "140m", time: "2 min"),

        MapPin(xRatio: 0.82, yRatio: 0.91,
               color: Color(hex: "#4CAF50"), hasDot: false, pulsing: false,
               label: "Payment",   distance: "250m", time: "4 min"),
    ]
}
