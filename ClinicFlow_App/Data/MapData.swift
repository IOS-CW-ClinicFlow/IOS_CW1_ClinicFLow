//
//  MapData.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-09.
//
import SwiftUI

struct MapData {

    // "You are here" position — ratios relative to the floor plan image
    static let currentPosition = CGPoint(x: 0.50, y: 0.55)

    // Aspect ratio of the MapFloor1 asset (height ÷ width)
    static let imageAspectRatio: CGFloat = 1.75

    static let pins: [MapPin] = [
        MapPin(xRatio: 0.25, yRatio: 0.17,
               color: Color(hex: "#4CAF50"), hasDot: false, pulsing: false,
               label: "Sharing Room",   distance: "50m",  time: "1 min"),

        MapPin(xRatio: 0.56, yRatio: 0.14,
               color: Color(hex: "#2196F3"), hasDot: true, pulsing: false,
               label: "Special Ward-1", distance: "120m", time: "2 min"),

        MapPin(xRatio: 0.20, yRatio: 0.35,
               color: Color(hex: "#F44336"), hasDot: true, pulsing: false,
               label: "Doctor Room",    distance: "80m",  time: "1 min"),

        MapPin(xRatio: 0.52, yRatio: 0.33,
               color: Color(hex: "#2196F3"), hasDot: true, pulsing: true,
               label: "Waiting Hall",   distance: "200m", time: "3 min"),

        MapPin(xRatio: 0.82, yRatio: 0.38,
               color: Color(hex: "#2196F3"), hasDot: true, pulsing: false,
               label: "Special Ward-2", distance: "160m", time: "2 min"),
    ]
}
