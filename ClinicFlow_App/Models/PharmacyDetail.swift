//
//  PharmacyDetail.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-11.
//
//
//  PharmacyDetail.swift
//  ClinicFlow_App

import Foundation

struct PharmacyChip: Identifiable {
    let id       = UUID()
    let label:   String
    let colorHex: String
    let iconName: String
}

struct PharmacyDetail: Identifiable, Equatable {
    let id          = UUID()
    let name:       String
    let subtitle:   String
    let imageName:  String
    let location:   String
    let hours:      String
    let about:      String
    let badges:     [PharmacyChip]   // named 'badges' to avoid init collision with LabDetail

    static func == (lhs: PharmacyDetail, rhs: PharmacyDetail) -> Bool {
        lhs.name == rhs.name
    }
}
