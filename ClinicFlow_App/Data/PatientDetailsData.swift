//
//  PatientDetailsData.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import Foundation

struct PatientDetailsData {

    static func defaultForm(for bookingFor: BookingFor) -> PatientForm {
        switch bookingFor {
        case .self:
            return PatientForm(
                bookingFor:   .self,
                fullName:     "Sandun Dias",
                mobile:       "+94 123456789",
                gender:       .male,
                age:          "34",
                relationship: .mother,
                problem:      ""
            )
        case .someoneElse:
            return PatientForm(
                bookingFor:   .someoneElse,
                fullName:     "",
                mobile:       "",
                gender:       .male,
                age:          "",
                relationship: .mother,
                problem:      ""
            )
        }
    }
}
