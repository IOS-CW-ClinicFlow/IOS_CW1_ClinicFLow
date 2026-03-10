//
//  AppointmentSlot.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import Foundation

struct DaySlot: Identifiable, Equatable {
    let id   = UUID()
    let day:  String   // e.g. "Today", "Mon"
    let date: String   // e.g. "4 Oct"
}

struct TimeSlot: Identifiable, Equatable {
    let id   = UUID()
    let time: String   // e.g. "7:00 PM"
}
