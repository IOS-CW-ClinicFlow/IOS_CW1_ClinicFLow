//
//  ConsultationCompleteScreen.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct ConsultationCompleteScreen: View {

    var onBack:                 () -> Void = {}
    var onGoPharmacy:           () -> Void = {}
    var onDownloadPrescription: () -> Void = {}
    var onGoLabTest:            (LabTest) -> Void = { _ in }

    var body: some View {
        VStack(spacing: 0) {

            // ── Top bar ────────────────────────────────────────────────────
            TopBar(title: "Consultation Complete", showBack: true, onBack: onBack)

            // ── Scrollable body ────────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {

                    // ── Prescription card ──────────────────────────────────
                    PrescriptionCard(
                        prescriptions: ConsultationData.prescriptions,
                        onGoPharmacy:  onGoPharmacy,
                        onDownload:    onDownloadPrescription
                    )

                    // ── Required Lab Tests ─────────────────────────────────
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Required Lab Tests")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(Color(hex: "#1a1a1a"))

                        ForEach(ConsultationData.labTests) { test in
                            LabTestRow(test: test) {
                                onGoLabTest(test)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 22)
            }
            .background(Color.white)
        }
        .background(Color.white)
    }
}

#Preview {
    ConsultationCompleteScreen()
}
