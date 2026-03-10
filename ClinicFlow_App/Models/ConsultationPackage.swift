//
//  ConsultationPackage.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import Foundation

struct ConsultationPackage: Identifiable, Equatable {
    let id:          String     // used for selection identity
    let label:       String     // e.g. "Voice Call"
    let description: String     // e.g. "Voice call with doctor"
    let price:       String     // e.g. "Rs 2000"
    let duration:    String     // e.g. "/15 mins"
    let icon:        String     // SF Symbol name

    static func == (lhs: ConsultationPackage, rhs: ConsultationPackage) -> Bool {
        lhs.id == rhs.id
    }
}
