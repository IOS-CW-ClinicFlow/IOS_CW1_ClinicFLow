//
//  PatientForm.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import Foundation

enum BookingFor: String, CaseIterable {
    case `self`        = "Self"
    case someoneElse   = "Someone else"
}

enum Gender: String, CaseIterable {
    case male   = "Male"
    case female = "Female"
    case other  = "Other"
}

enum Relationship: String, CaseIterable {
    case mother  = "Mother"
    case father  = "Father"
    case spouse  = "Spouse"
    case child   = "Child"
    case sibling = "Sibling"
    case other   = "Other"
}

struct PatientForm {
    var bookingFor:   BookingFor   = .self
    var fullName:     String       = ""
    var mobile:       String       = ""
    var gender:       Gender       = .male
    var age:          String       = ""   // free text, validated as numeric 1–120
    var relationship: Relationship = .mother
    var problem:      String       = ""
}
