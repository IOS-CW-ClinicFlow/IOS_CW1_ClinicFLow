//
//  DoctorDetail.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import Foundation

struct WorkingHours: Identifiable, Equatable {
    let id   = UUID()
    let day:   String
    let hours: String

    static func == (lhs: WorkingHours, rhs: WorkingHours) -> Bool {
        lhs.day == rhs.day && lhs.hours == rhs.hours
    }
}

struct DoctorDetail: Identifiable, Equatable {
    let id           = UUID()
    let name:        String
    let specialty:   String
    let avatarName:  String
    let patients:    String
    let experience:  String
    let rating:      String
    let about:       String
    let workingHours: [WorkingHours]

    static func == (lhs: DoctorDetail, rhs: DoctorDetail) -> Bool {
        lhs.name == rhs.name && lhs.specialty == rhs.specialty
    }
}
