//
//  PaymentMe.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-051 on 2026-03-10.
//
import Foundation

enum PaymentMethod: String, CaseIterable, Identifiable {
    case card = "Add New Card"
    case bank = "Bank Transfer"
    case cash = "Cash Payment"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .card: return "creditcard"
        case .bank: return "building.columns"
        case .cash: return "banknote"
        }
    }

    var iconColorHex: String {
        switch self {
        case .card: return "#2196F3"
        case .bank: return "#37474F"
        case .cash: return "#4CAF50"
        }
    }

    var section: PaymentSection {
        switch self {
        case .card:         return .cardSection
        case .bank, .cash:  return .otherSection
        }
    }
}

enum PaymentSection: String {
    case cardSection  = "Credit & Debit Card"
    case otherSection = "Other Payment Options"
}
