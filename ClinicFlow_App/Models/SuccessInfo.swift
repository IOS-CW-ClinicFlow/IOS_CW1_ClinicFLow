//
//  SuccessInfo.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import Foundation

// ── What type of success this screen represents ───────────────────────────────
enum SuccessKind: Equatable {
    // Doctor booking — cash/bank payment
    case bookingConfirm

    // Doctor booking — card payment (shows "Payment Successful!")
    case paymentSuccess

    // Lab booking — cash/bank
    case labBookingConfirm

    // Lab booking — card payment
    case labPaymentSuccess

    // Pharmacy — order placed (card/cash)
    case pharmacyOrderConfirmed

    // Pharmacy — order ready for pickup
    case pharmacyOrderComplete

    // ── Derived display properties ────────────────────────────────────────

    var navTitle: String {
        switch self {
        case .paymentSuccess, .labPaymentSuccess, .pharmacyOrderConfirmed:
            return "Payment"
        case .bookingConfirm, .labBookingConfirm, .pharmacyOrderComplete:
            return "Booking Confirm"
        }
    }

    var headline: String {
        switch self {
        case .bookingConfirm, .labBookingConfirm:   return "Booking Successful!"
        case .paymentSuccess, .labPaymentSuccess:   return "Payment Successful!"
        case .pharmacyOrderConfirmed:               return "Order Confirmed!"
        case .pharmacyOrderComplete:                return "Order Complete!"
    }
    }

    var primaryButtonLabel: String {
        switch self {
        case .paymentSuccess, .labPaymentSuccess:
            return "Next"

        case .bookingConfirm, .labBookingConfirm:
            return "View Booking"

        case .pharmacyOrderConfirmed:
            return "View Order"

        case .pharmacyOrderComplete:
            return "Go to Collect"
        }
    }

    var isPharmacy: Bool {
        self == .pharmacyOrderConfirmed || self == .pharmacyOrderComplete
    }

    // "Go to Home" only shown on booking/order success, NOT on payment success
    var showGoHome: Bool {
        switch self {
        case .paymentSuccess, .labPaymentSuccess: return false
        default:                                  return true
        }
    }
}

// ── Detail row descriptor ─────────────────────────────────────────────────────
struct SuccessDetail: Identifiable {
    let id          = UUID()
    let iconName:   String          // SF Symbol
    let iconColor:  String          // hex
    let value:      String
    var valueColor: String = "#1a1a1a"
}

// ── Full info passed to the screen ────────────────────────────────────────────
struct SuccessInfo: Equatable {
    let kind:        SuccessKind
    let entityName:  String          // doctor / lab / pharmacy name
    let subtitle:    String?         // nil = default "booked appointment with"
    let details:     [SuccessDetail]

    static func == (lhs: SuccessInfo, rhs: SuccessInfo) -> Bool {
        lhs.kind == rhs.kind && lhs.entityName == rhs.entityName
    }
}
