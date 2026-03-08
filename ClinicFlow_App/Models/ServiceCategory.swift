//
//  ServiceCategory.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import Foundation

enum ServiceCategory: String, CaseIterable {
    case emergency = "Emergency"
    case doctors   = "Doctors"
    case labs      = "Labs"
    case pharmacy  = "Pharmacy"

    var systemImage: String {
        switch self {
        case .emergency: return "cross.fill"
        case .doctors:   return "stethoscope"
        case .labs:      return "flask.fill"
        case .pharmacy:  return "cross.vial.fill"
        }
    }
}
