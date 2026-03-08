//
//  Appointment.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import Foundation

struct Appointment: Identifiable {
    let id = UUID()
    let doctorName: String
    let specialty: String
    let date: String
    let timeSlot: String
    let avatarName: String
}
