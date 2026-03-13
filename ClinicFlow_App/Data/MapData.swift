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

    static let pins: [MapPin] = [

        // ── Top row ───────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.13,
               color: Color(hex: "#4CAF50"), hasDot: false, pulsing: false,
               label: "Reception",    distance: "180m", time: "3 min",
               mapPinId: "reception"),

        MapPin(xRatio: 0.50, yRatio: 0.11,
               color: Color(hex: "#4CAF50"), hasDot: false, pulsing: false,
               label: "Registration", distance: "200m", time: "3 min",
               mapPinId: "registration"),

        MapPin(xRatio: 0.82, yRatio: 0.13,
               color: Color(hex: "#9C27B0"), hasDot: true, pulsing: false,
               label: "Laboratory",   distance: "210m", time: "4 min",
               mapPinId: "laboratory"),

        // ── Second row ────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.28,
               color: Color(hex: "#2196F3"), hasDot: true, pulsing: false,
               label: "Sharing Room",   distance: "120m", time: "2 min",
               mapPinId: "sharing-room"),

        MapPin(xRatio: 0.82, yRatio: 0.28,
               color: Color(hex: "#2196F3"), hasDot: true, pulsing: false,
               label: "Special Ward-1", distance: "150m", time: "2 min",
               mapPinId: "special-ward-1"),

        // ── Third row ─────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.41,
               color: Color(hex: "#F44336"), hasDot: true, pulsing: false,
               label: "Doctor Room",  distance: "80m",  time: "1 min",
               mapPinId: "doctor-room"),

        MapPin(xRatio: 0.50, yRatio: 0.46,
               color: Color(hex: "#FF9800"), hasDot: true, pulsing: true,
               label: "Waiting Hall", distance: "0m",   time: "You are here",
               mapPinId: "waiting-hall"),

        MapPin(xRatio: 0.82, yRatio: 0.41,
               color: Color(hex: "#9C27B0"), hasDot: true, pulsing: false,
               label: "X-Ray Room",   distance: "160m", time: "2 min",
               mapPinId: "xray-room"),

        // ── Fourth row ────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.55,
               color: Color(hex: "#2196F3"), hasDot: false, pulsing: false,
               label: "Consultation Room", distance: "60m",  time: "1 min",
               mapPinId: "consultation-room"),

        MapPin(xRatio: 0.82, yRatio: 0.55,
               color: Color(hex: "#2196F3"), hasDot: true, pulsing: false,
               label: "Special Ward-2",    distance: "170m", time: "3 min",
               mapPinId: "special-ward-2"),

        // ── Fifth row ─────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.68,
               color: Color(hex: "#F44336"), hasDot: true, pulsing: false,
               label: "Emergency Room", distance: "90m",  time: "1 min",
               mapPinId: "emergency-room"),

        MapPin(xRatio: 0.82, yRatio: 0.68,
               color: Color(hex: "#F44336"), hasDot: true, pulsing: false,
               label: "ICU",            distance: "200m", time: "3 min",
               mapPinId: "icu"),

        // ── Sixth row ─────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.80,
               color: Color(hex: "#4CAF50"), hasDot: false, pulsing: false,
               label: "Nurse Station", distance: "100m", time: "2 min",
               mapPinId: "nurse-station"),

        MapPin(xRatio: 0.50, yRatio: 0.82,
               color: Color(hex: "#4CAF50"), hasDot: false, pulsing: false,
               label: "Pharmacy",      distance: "130m", time: "2 min",
               mapPinId: "pharmacy"),

        MapPin(xRatio: 0.82, yRatio: 0.80,
               color: Color(hex: "#9C27B0"), hasDot: true, pulsing: false,
               label: "CT Scan",       distance: "220m", time: "4 min",
               mapPinId: "ct-scan"),

        // ── Bottom row ────────────────────────────────────────────────────
        MapPin(xRatio: 0.18, yRatio: 0.91,
               color: Color(hex: "#607D8B"), hasDot: false, pulsing: false,
               label: "Washrooms", distance: "140m", time: "2 min",
               mapPinId: "washrooms"),

        MapPin(xRatio: 0.82, yRatio: 0.91,
               color: Color(hex: "#4CAF50"), hasDot: false, pulsing: false,
               label: "Payment",   distance: "250m", time: "4 min",
               mapPinId: "payment"),
    ]
}
