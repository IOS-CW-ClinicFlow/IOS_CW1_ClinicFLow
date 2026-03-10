//
//  PatientInfo.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import Foundation

struct PatientInfo: Identifiable {
    let id       = UUID()
    let fullName: String
    let gender:   String
    let age:      String
    let problem:  String
}
