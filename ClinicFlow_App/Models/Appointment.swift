//
//  Appointment.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-08.
//
import Foundation

enum AppointmentStatus: String, CaseIterable, Equatable {
    case upcoming  = "Upcoming"
    case completed = "Completed"
    case cancelled = "Cancelled"
}

struct Appointment: Identifiable, Equatable {
    let id           = UUID()
    let doctorName:  String
    let specialty:   String
    let date:        String
    let time:        String
    let location:    String
    let bookingId:   String
    let avatarName:  String
    let status:      AppointmentStatus
    var remindMe:    Bool = false
    var doctorSlug:  String = ""   // links to DoctorDetailData.bySlug

    // Exclude auto-generated id from equality so two appointments
    // with the same data are considered equal regardless of UUID
    static func == (lhs: Appointment, rhs: Appointment) -> Bool {
        lhs.doctorName == rhs.doctorName &&
        lhs.specialty  == rhs.specialty  &&
        lhs.date       == rhs.date       &&
        lhs.time       == rhs.time       &&
        lhs.location   == rhs.location   &&
        lhs.bookingId  == rhs.bookingId  &&
        lhs.avatarName == rhs.avatarName &&
        lhs.status     == rhs.status     &&
        lhs.remindMe   == rhs.remindMe
    }
}
