//
//  PatientFormValidator.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import Foundation

struct PatientFormErrors {
    var fullName:     String? = nil
    var mobile:       String? = nil
    var age:          String? = nil
    var relationship: String? = nil
    var problem:      String? = nil

    var hasErrors: Bool {
        [fullName, mobile, age, relationship, problem].contains(where: { $0 != nil })
    }
}

struct PatientFormValidator {

    static func validate(_ form: PatientForm) -> PatientFormErrors {
        var errors = PatientFormErrors()

        // ── Full name ──────────────────────────────────────────────────────
        // Required, at least 2 words, no digits allowed
        let nameTrimmed = form.fullName.trimmingCharacters(in: .whitespaces)
        if nameTrimmed.isEmpty {
            errors.fullName = "Full name is required"
        } else if nameTrimmed.rangeOfCharacter(from: .decimalDigits) != nil {
            errors.fullName = "Name cannot contain numbers"
        } else if nameTrimmed.split(separator: " ").count < 2 {
            errors.fullName = "Please enter your full name"
        }

        // ── Mobile ─────────────────────────────────────────────────────────
        // Allowed formats: +94XXXXXXXXX (11 chars) or 0XXXXXXXXX (10 digits)
        // No letters allowed. Digits only after stripping leading +94 or 0.
        let mobileTrimmed = form.mobile.trimmingCharacters(in: .whitespaces)

        if mobileTrimmed.isEmpty {
            errors.mobile = "Mobile number is required"
        } else {
            // Check for any letters in the input
            let hasLetters = mobileTrimmed.contains(where: { $0.isLetter && $0 != "+" })
            if hasLetters {
                errors.mobile = "Mobile number cannot contain letters"
            } else {
                let digits = mobileTrimmed.filter(\.isNumber)
                if mobileTrimmed.hasPrefix("+94") {
                    // +94 followed by exactly 9 digits = 11 total chars
                    if digits.count != 11 {
                        errors.mobile = "Enter a valid number: +94 followed by 9 digits"
                    }
                } else {
                    // Without +94 prefix — expect exactly 9 digits
                    if digits.count < 9 {
                        errors.mobile = "Mobile number must be exactly 9 digits"
                    } else if digits.count > 9 {
                        errors.mobile = "Mobile number must not exceed 9 digits"
                    }
                }
            }
        }

        // ── Age ────────────────────────────────────────────────────────────
        // Required, numeric only, between 1 and 120
        let ageTrimmed = form.age.trimmingCharacters(in: .whitespaces)
        if ageTrimmed.isEmpty {
            errors.age = "Age is required"
        } else if ageTrimmed.contains(where: { !$0.isNumber }) {
            errors.age = "Age must be a number"
        } else if let ageInt = Int(ageTrimmed) {
            if ageInt < 1 {
                errors.age = "Age must be at least 1"
            } else if ageInt > 120 {
                errors.age = "Please enter a valid age"
            }
        } else {
            errors.age = "Age must be a number"
        }

        // ── Relationship / Booking for  ─────────────────────────────────────────
        if form.bookingFor == .someoneElse && form.relationship == .unselected {
            errors.relationship = "Please select a relationship"
        }

        // ── Problem ────────────────────────────────────────────────────────
        // Optional but warn if filled with too little detail
        let problemTrimmed = form.problem.trimmingCharacters(in: .whitespaces)
        if !problemTrimmed.isEmpty && problemTrimmed.count < 5 {
            errors.problem = "Please describe your problem in more detail"
        }

        return errors
    }
}
