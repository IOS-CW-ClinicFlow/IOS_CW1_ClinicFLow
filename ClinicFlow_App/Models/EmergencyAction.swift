//
//  EmergencyAction.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-10.
//
import SwiftUI

enum EmergencyActionType: String, CaseIterable, Identifiable {
    case callHelp   = "Call for Help"
    case wheelchair = "Wheelchair Assistance"
    case ambulance  = "Request Ambulance"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .callHelp:   return "phone.fill"
        case .wheelchair: return "figure.roll"
        case .ambulance:  return "cross.case.fill"
        }
    }

    var description: String {
        switch self {
        case .callHelp:   return "Connect to clinic staff immediately"
        case .wheelchair: return "Request a wheelchair at your location"
        case .ambulance:  return "Dispatch an ambulance to the clinic"
        }
    }

    var accentColorHex: String {
        switch self {
        case .callHelp:   return "#FF3B30"
        case .wheelchair: return "#2196F3"
        case .ambulance:  return "#FF6B35"
        }
    }

    var isCallAction: Bool {
        self == .callHelp || self == .ambulance
    }
}

struct EmergencyContact {
    let label: String
    let number: String
}
