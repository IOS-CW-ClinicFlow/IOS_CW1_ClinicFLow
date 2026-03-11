//
//  ConsultationData.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import Foundation

struct ConsultationData {

    static let prescriptions: [Prescription] = [
        Prescription(name: "Amoxillin",   dose: "500mg"),
        Prescription(name: "Paracetamol", dose: "650mg"),
        Prescription(name: "Cetirizine",  dose: "100mg"),
        Prescription(name: "Vitamin C",   dose: "500mg"),
    ]

    static let labTests: [LabTest] = [
        LabTest(name: "ECG",   urgency: .urgent, destination: "ECG",slug: "ecg"),
        LabTest(name: "X-Ray", urgency: .normal, destination: "XRay",slug: "xray"),
    ]
}
