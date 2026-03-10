//
//  PatientDetailsData.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
//
//  PatientDetailsData.swift
//  ClinicFlow_App

import Foundation

struct PatientDetailsData {

    static func defaultForm(for bookingFor: BookingFor) -> PatientForm {
        switch bookingFor {
        case .self:
            return PatientForm(
                bookingFor:   .self,
                fullName:     "Saman Edirimuna",
                mobile:       "+94 78 665 7709",
                gender:       .male,
                age:          "34",
                relationship: .mother,
                problem:      ""
            )
        case .someoneElse:
            return PatientForm(
                bookingFor:   .someoneElse,
                fullName:     "Rani Edirimuna",
                mobile:       "+94 78 665 7709",
                gender:       .female,
                age:          "67",
                relationship: .mother,
                problem:      ""
            )
        }
    }
}
