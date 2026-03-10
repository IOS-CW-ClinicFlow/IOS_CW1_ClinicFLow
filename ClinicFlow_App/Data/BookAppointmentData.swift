//
//  BookAppointmentData.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import Foundation

struct BookAppointmentData {

    static let days: [DaySlot] = [
        DaySlot(day: "Today", date: "4 Oct"),
        DaySlot(day: "Mon",   date: "5 Oct"),
        DaySlot(day: "Tue",   date: "6 Oct"),
        DaySlot(day: "Wed",   date: "7 Oct"),
        DaySlot(day: "Thu",   date: "8 Oct"),
    ]

    static let times: [TimeSlot] = [
        TimeSlot(time: "7:00 PM"),
        TimeSlot(time: "7:30 PM"),
        TimeSlot(time: "8:00 PM"),
        TimeSlot(time: "8:30 PM"),
        TimeSlot(time: "9:00 PM"),
    ]
}
