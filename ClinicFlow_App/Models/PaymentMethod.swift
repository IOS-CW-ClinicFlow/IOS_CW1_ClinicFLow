//
//  PaymentMethod.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-051 on 2026-03-10.
//
import Foundation

enum PaymentMethod: String, CaseIterable, Identifiable {
    case card = "Add New Card"
    case cash = "Cash Payment"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .card: return "creditcard"
        case .cash: return "banknote"
        }
    }

    var iconColorHex: String {
        switch self {
        case .card: return "#2196F3"
        case .cash: return "#4CAF50"
        }
    }

    var section: PaymentSection {
        switch self {
        case .card:         return .cardSection
        case .cash:  return .otherSection
        }
    }
}

enum PaymentSection: String {
    case cardSection  = "Credit & Debit Card"
    case otherSection = "Other Payment Options"
}
