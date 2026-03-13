//
//  MapPin.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-09.
//
//
import SwiftUI

struct MapPin: Identifiable {
    let xRatio: CGFloat
    let yRatio: CGFloat
    let color: Color
    let hasDot: Bool
    let pulsing: Bool
    let label: String
    let distance: String
    let time: String
    let mapPinId: String       
    var id: String { mapPinId }
}
