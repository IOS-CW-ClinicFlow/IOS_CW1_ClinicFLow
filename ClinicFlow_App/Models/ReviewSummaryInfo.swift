//
//  ReviewSummaryInfo.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import Foundation

// Covers both doctor bookings and lab bookings
enum BookingContext: Equatable {
    case doctor(DoctorDetail)
    case lab(labName: String, labImageName: String)
}

struct ReviewSummaryInfo: Equatable {
    let context:        BookingContext
    let dateAndHour:    String
    let packageName:    String
    let bookingFor:     String
    let amount:         String          // e.g. "Rs 4000"
    let paymentMethod:  PaymentMethod   // chosen on PaymentScreen
}
