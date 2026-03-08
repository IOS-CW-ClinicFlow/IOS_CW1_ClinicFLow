//
//  Cftab.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import Foundation

enum CFTab: String, CaseIterable, Equatable {
    case home         = "Home"
    case services     = "Services"
    case appointments = "Appointments"
    case map          = "Map"
    case profile      = "Profile"

    /// SF Symbol name used for each tab's icon.
    var systemImage: String {
        switch self {
        case .home:         return "house"
        case .services:     return "squares.below.rectangle"
        case .appointments: return "calendar"
        case .map:          return "map"
        case .profile:      return "person"
        }
    }
}
