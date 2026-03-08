//
//  ServicesScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct ServicesScreen: View {

    var initialTab: ServicesTab       = .doctor
    var onBack:          () -> Void   = {}
    var onDoctorTap:     (ServiceDoctor) -> Void = { _ in }
    var onLabTap:        (ServicePlace)  -> Void = { _ in }
    var onPharmacyTap:   (ServicePlace)  -> Void = { _ in }
    var onAppointment:   (ServiceDoctor) -> Void = { _ in }

    @State private var activeTab: ServicesTab = .doctor

    init(initialTab: ServicesTab = .doctor,
         onBack: @escaping () -> Void = {},
         onDoctorTap: @escaping (ServiceDoctor) -> Void = { _ in },
         onLabTap: @escaping (ServicePlace) -> Void = { _ in },
         onPharmacyTap: @escaping (ServicePlace) -> Void = { _ in },
         onAppointment: @escaping (ServiceDoctor) -> Void = { _ in }) {
        self.initialTab     = initialTab
        self.onBack         = onBack
        self.onDoctorTap    = onDoctorTap
        self.onLabTap       = onLabTap
        self.onPharmacyTap  = onPharmacyTap
        self.onAppointment  = onAppointment
        _activeTab = State(initialValue: initialTab)
    }

    var body: some View {
        VStack(spacing: 0) {

            // ── Fixed top bar ──────────────────────────────────────────────
            topBar

            // ── Fixed tab bar ──────────────────────────────────────────────
            tabBar

            // ── Scrollable content ─────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    switch activeTab {
                    case .doctor:
                        ForEach(ServicesData.doctors) { doctor in
                            ServiceDoctorCard(
                                doctor: doctor,
                                onTap: { onDoctorTap(doctor) },
                                onAppointment: { onAppointment(doctor) }
                            )
                        }
                    case .lab:
                        ForEach(ServicesData.labs) { lab in
                            ServicePlaceCard(place: lab, onTap: { onLabTap(lab) })
                        }
                    case .pharmacy:
                        ForEach(ServicesData.pharmacies) { pharmacy in
                            ServicePlaceCard(place: pharmacy, onTap: { onPharmacyTap(pharmacy) })
                        }
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 16)
                .padding(.bottom, 24)
            }
            .background(Color(hex: "#F4F6FB"))

        }
        .background(Color(hex: "#F4F6FB"))
    }

    // ── Top bar ────────────────────────────────────────────────────────────

    private var topBar: some View {
        HStack {
            // Back button
            Button { onBack() } label: {
                ZStack {
                    Circle()
                        .fill(Color(hex: "#F2F2F7"))
                        .frame(width: 36, height: 36)
                    Image(systemName: "chevron.left")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                }
            }
            .buttonStyle(.plain)

            Spacer()

            Text("Services")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(Color(hex: "#1a1a1a"))
                .kerning(-0.3)

            Spacer()

            // Search icon
            Button {} label: {
                ZStack {
                    Circle()
                        .fill(Color(hex: "#F2F2F7"))
                        .frame(width: 36, height: 36)
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color(hex: "#555555"))
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 18)
        .padding(.top, 12)
        .padding(.bottom, 8)
        .background(Color.white)
    }

    // ── Tab bar ────────────────────────────────────────────────────────────

    private var tabBar: some View {
        HStack(spacing: 0) {
            ForEach(ServicesTab.allCases, id: \.self) { tab in
                let isActive = tab == activeTab
                Button { activeTab = tab } label: {
                    VStack(spacing: 0) {
                        Text(tab.rawValue)
                            .font(.system(size: 14, weight: isActive ? .bold : .medium))
                            .foregroundColor(isActive ? Color(hex: "#2196F3") : Color(hex: "#999999"))
                            .padding(.vertical, 12)

                        // Active underline
                        Rectangle()
                            .fill(isActive ? Color(hex: "#2196F3") : Color.clear)
                            .frame(height: 2.5)
                    }
                }
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 18)
        .background(Color.white)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color(hex: "#F0F0F5"))
                .frame(height: 1.5)
        }
    }
}

// ── Preview ────────────────────────────────────────────────────────────────────

#Preview("Doctor") { ServicesScreen(initialTab: .doctor) }
#Preview("Lab")    { ServicesScreen(initialTab: .lab) }
#Preview("Pharmacy") { ServicesScreen(initialTab: .pharmacy) }
