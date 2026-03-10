//
//  Appointment.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import Foundation

enum AppointmentStatus: String, CaseIterable {
    case upcoming  = "Upcoming"
    case completed = "Completed"
    case cancelled = "Cancelled"
}

struct Appointment: Identifiable {
    let id        = UUID()
    let doctorName:  String
    let specialty:   String
    let date:        String        // e.g. "Mar 25, 2026"
    let time:        String        // e.g. "10:00 AM"
    let location:    String        // e.g. "Floor 1, Room 7"
    let bookingId:   String        // e.g. "#DR4S2SA54"
    let avatarName:  String
    let status:      AppointmentStatus
    var remindMe:    Bool = false
}
