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

        // Full name — required, at least 2 words
        let nameTrimmed = form.fullName.trimmingCharacters(in: .whitespaces)
        if nameTrimmed.isEmpty {
            errors.fullName = "Full name is required"
        } else if nameTrimmed.split(separator: " ").count < 2 {
            errors.fullName = "Please enter your full name"
        }

        // Mobile — required, basic format check
        let digits = form.mobile.filter(\.isNumber)
        if form.mobile.trimmingCharacters(in: .whitespaces).isEmpty {
            errors.mobile = "Mobile number is required"
        } else if digits.count < 9 {
            errors.mobile = "Enter a valid mobile number"
        }

        // Age — required, numeric, between 1 and 120
        let ageTrimmed = form.age.trimmingCharacters(in: .whitespaces)
        if ageTrimmed.isEmpty {
            errors.age = "Age is required"
        } else if let ageInt = Int(ageTrimmed) {
            if ageInt < 1 {
                errors.age = "Age must be at least 1"
            } else if ageInt > 120 {
                errors.age = "Please enter a valid age"
            }
        } else {
            errors.age = "Age must be a number"
        }

        // Relationship — only validated when booking for someone else
        // (No free-text so always valid, included for future custom input)

        // Problem — optional but warn if very short when filled
        let problemTrimmed = form.problem.trimmingCharacters(in: .whitespaces)
        if !problemTrimmed.isEmpty && problemTrimmed.count < 5 {
            errors.problem = "Please describe your problem in more detail"
        }

        return errors
    }
}
