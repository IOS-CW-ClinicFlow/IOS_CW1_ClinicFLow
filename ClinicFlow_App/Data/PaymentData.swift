//
//  PaymentData.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-051 on 2026-03-10.
//
import Foundation

enum PaymentData {
    static let cardMethods:  [PaymentMethod] = [.card]
    static let otherMethods: [PaymentMethod] = [.bank, .cash]
    static let defaultMethod: PaymentMethod  = .card
}
