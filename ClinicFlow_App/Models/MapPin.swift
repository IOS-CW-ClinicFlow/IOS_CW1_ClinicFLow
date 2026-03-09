//
//  MapPin.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-09.
//
//
import SwiftUI

struct MapPin: Identifiable {
    let id = UUID()
    let xRatio: CGFloat     // 0–1 relative to image width
    let yRatio: CGFloat     // 0–1 relative to image height
    let color: Color
    let hasDot: Bool
    let pulsing: Bool
    let label: String
    let distance: String    // e.g. "120m"
    let time: String        // e.g. "2 min"
}
