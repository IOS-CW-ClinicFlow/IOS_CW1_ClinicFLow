//
//  ReviewSummaryData.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import Foundation

enum ReviewSummaryData {

    // Default doctor preview (used in #Preview)
    static func doctorPreview(for doctor: DoctorDetail) -> ReviewSummaryInfo {
        ReviewSummaryInfo(
            context:       .doctor(doctor),
            dateAndHour:   "October 4, 2026 | 07:00 PM",
            packageName:   "Visiting",
            bookingFor:    "Self",
            amount:        "Rs 4,000",
            paymentMethod: .card
        )
    }

    // Default lab preview
    static func labPreview(name: String, imageName: String) -> ReviewSummaryInfo {
        ReviewSummaryInfo(
            context:       .lab(labName: name, labImageName: imageName),
            dateAndHour:   "October 4, 2026 | 09:00 AM",
            packageName:   "Full Blood Count",
            bookingFor:    "Self",
            amount:        "Rs 1,500",
            paymentMethod: .card
        )
    }
}
