//
//  LabDetail.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import Foundation

struct LabChip: Identifiable {
    let id        = UUID()
    let label:    String
    let colorHex: String
    let iconName: String   // SF Symbol
}

struct LabSlot: Identifiable {
    let id   = UUID()
    let day:  String   // e.g. "Today", "Mon"
    let date: String   // e.g. "4 Oct"
}

struct LabDetail: Identifiable, Equatable {
    let id          = UUID()
    let name:       String       // e.g. "X - Ray"
    let subtitle:   String       // e.g. "Radiology, Skeletal"
    let imageName:  String       // asset name
    let location:   String
    let hours:      String
    let about:      String
    let serviceFee: String       // e.g. "Rs. 2,000"
    let chips:      [LabChip]
    let slots:      [LabSlot]
    let times:      [String]
    let phone:      String
    let mapQuery:   String

    static func == (lhs: LabDetail, rhs: LabDetail) -> Bool {
        lhs.name == rhs.name
    }
}
