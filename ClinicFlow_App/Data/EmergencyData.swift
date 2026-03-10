//
//  EmergencyData.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-10.
//
import Foundation

enum EmergencyData {

    static let contacts: [EmergencyActionType: EmergencyContact] = [
        .callHelp:  EmergencyContact(label: "ClinicFlow Admin",  number: "+94112345678"),
        .ambulance: EmergencyContact(label: "Ambulance Service", number: "+94119"),
    ]

    static let actions: [EmergencyActionType] = [
        .callHelp,
        .wheelchair,
        .ambulance,
    ]
}
