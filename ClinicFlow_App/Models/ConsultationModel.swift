//
//  ConsultationModel.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
//
import Foundation

struct Prescription: Identifiable {
    let id   = UUID()
    let name: String
    let dose: String
}

enum LabTestUrgency {
    case urgent
    case normal
}

struct LabTest: Identifiable {
    let id:       UUID = UUID()
    let name:     String
    let urgency:  LabTestUrgency
    let destination: String   // e.g. "ECG", "X-Ray"
    let slug:        String
}
