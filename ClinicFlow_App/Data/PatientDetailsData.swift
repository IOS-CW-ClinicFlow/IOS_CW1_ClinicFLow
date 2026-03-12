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
                fullName:     "vccc fff",
                mobile:       "+8997788889",
                gender:       .male,
                age:          "44",
                relationship: .mother,
                problem:      ""
            )
        case .someoneElse:
            return PatientForm(
                bookingFor:   .someoneElse,
                fullName:     "zczxcv",
                mobile:       "34643643444",
                gender:       .male,
                age:          "44",
                relationship: .mother,
                problem:      ""
            )
        }
    }
}
