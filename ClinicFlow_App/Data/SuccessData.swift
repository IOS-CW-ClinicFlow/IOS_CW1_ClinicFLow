//
//  SuccessData.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import Foundation

enum SuccessData {

    // ── Doctor — booking confirm (cash / bank) ────────────────────────────
    static func doctorBooking(
        entityName:  String = "Dr. Ryan De Silva",
        patientName: String = "Saman Edirimuna",
        amount:      String = "Rs 4,000",
        date:        String = "4 Oct, 2026",
        time:        String = "07:00 PM"
    ) -> SuccessInfo {
        SuccessInfo(
            kind:       .bookingConfirm,
            entityName: entityName,
            subtitle:   nil,
            details:    appointmentDetails(patientName: patientName,
                                           amount: amount, date: date, time: time)
        )
    }

    // ── Doctor — payment success (card) ───────────────────────────────────
    static func doctorPayment(
        entityName:  String = "Dr. Ryan De Silva",
        patientName: String = "Saman Edirimuna",
        amount:      String = "Rs 4,000",
        date:        String = "4 Oct, 2026",
        time:        String = "07:00 PM"
    ) -> SuccessInfo {
        SuccessInfo(
            kind:       .paymentSuccess,
            entityName: entityName,
            subtitle:   nil,
            details:    appointmentDetails(patientName: patientName,
                                           amount: amount, date: date, time: time)
        )
    }

    // ── Lab — booking confirm (cash / bank) ───────────────────────────────
    static func labBooking(
        entityName:  String = "X - Ray Lab",
        patientName: String = "Saman Edirimuna",
        amount:      String = "Rs 2,000",
        date:        String = "4 Oct, 2026",
        time:        String = "07:00 PM"
    ) -> SuccessInfo {
        SuccessInfo(
            kind:       .labBookingConfirm,
            entityName: entityName,
            subtitle:   nil,
            details:    appointmentDetails(patientName: patientName,
                                           amount: amount, date: date, time: time)
        )
    }

    // ── Lab — payment success (card) ──────────────────────────────────────
    static func labPayment(
        entityName:  String = "X - Ray Lab",
        patientName: String = "Saman Edirimuna",
        amount:      String = "Rs 2,000",
        date:        String = "4 Oct, 2026",
        time:        String = "07:00 PM"
    ) -> SuccessInfo {
        SuccessInfo(
            kind:       .labPaymentSuccess,
            entityName: entityName,
            subtitle:   nil,
            details:    appointmentDetails(patientName: patientName,
                                           amount: amount, date: date, time: time)
        )
    }

    // ── Pharmacy — order confirmed ────────────────────────────────────────
    static func pharmacyOrderConfirmed(
        entityName:    String = "City Pharmacy",
        estimatedTime: String = "15 mins"
    ) -> SuccessInfo {
        SuccessInfo(
            kind:       .pharmacyOrderConfirmed,
            entityName: entityName,
            subtitle:   "You will be notified when the order is completed",
            details: [
                SuccessDetail(iconName: "clock.fill",
                              iconColor: "#2196F3",
                              value: "Estimated Time :  \(estimatedTime)")
            ]
        )
    }

    // ── Pharmacy — order complete / ready ─────────────────────────────────
    static func pharmacyOrderComplete(
        entityName:  String = "City Pharmacy",
        patientName: String = "Saman Edirimuna",
        amount:      String = "Rs 3,500",
        date:        String = "4 Oct, 2026",
        counter:     String = "Counter 2"
    ) -> SuccessInfo {
        SuccessInfo(
            kind:       .pharmacyOrderComplete,
            entityName: entityName,
            subtitle:   "Your pharmacy order is processed and complete. Please collect your order at **\(counter)**",
            details: [
                SuccessDetail(iconName: "person.fill",    iconColor: "#2196F3", value: patientName),
                SuccessDetail(iconName: "dollarsign.circle.fill",
                              iconColor: "#4CAF50", value: amount, valueColor: "#4CAF50"),
                SuccessDetail(iconName: "calendar",       iconColor: "#2196F3", value: date),
                SuccessDetail(iconName: "tray.fill",      iconColor: "#2196F3", value: counter),
            ]
        )
    }

    // ── Shared appointment detail rows ────────────────────────────────────
    private static func appointmentDetails(
        patientName: String,
        amount:      String,
        date:        String,
        time:        String
    ) -> [SuccessDetail] {
        [
            SuccessDetail(iconName: "person.fill",
                          iconColor: "#2196F3",
                          value: patientName),
            SuccessDetail(iconName: "dollarsign.circle.fill",
                          iconColor: "#4CAF50",
                          value: amount,
                          valueColor: "#4CAF50"),
            SuccessDetail(iconName: "calendar",
                          iconColor: "#2196F3",
                          value: date),
            SuccessDetail(iconName: "clock.fill",
                          iconColor: "#2196F3",
                          value: time),
        ]
    }
}
