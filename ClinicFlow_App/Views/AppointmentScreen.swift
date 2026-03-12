//
//  AppointmentScreen.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct AppointmentsScreen: View {

    var onBack:            () -> Void            = {}
    var onAppointmentTap:  (Appointment) -> Void = { _ in }
    var onStartNow:        (Appointment) -> Void = { _ in }
    var onReschedule:      (Appointment) -> Void = { _ in }
    var onReBook:          (Appointment) -> Void = { _ in }
    var onView:            (Appointment) -> Void = { _ in }
    
    @State private var activeTab: AppointmentStatus = .upcoming
    @State private var showSearch: Bool = false
    @State private var remindStates: [UUID: Bool] = {
        var dict: [UUID: Bool] = [:]
        AppointmentsData.appointments.forEach { dict[$0.id] = $0.remindMe }
        return dict
    }()

    private var filtered: [Appointment] {
        AppointmentsData.appointments.filter { $0.status == activeTab }
    }

    private let screenTitle = "My Appointments"

    var body: some View {
        VStack(spacing: 0) {

            // ── Top bar ────────────────────────────────────────────────────
            TopBar(
                title:          screenTitle,
                showBack:       true,
                showSearch:     true,
                isSearchActive: showSearch,
                onBack:         onBack,
                onSearch:       { withAnimation(.easeInOut(duration: 0.2)) { showSearch.toggle() } }
            )

            // ── Collapsible search bar ─────────────────────────────────────
            if showSearch {
                SearchBar(placeholder: "Search Appointments")
                    .transition(.move(edge: .top).combined(with: .opacity))
            }

            // ── Tab bar ────────────────────────────────────────────────────
            tabBar

            // ── Content ────────────────────────────────────────────────────
            if filtered.isEmpty {
                emptyState
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {
                        ForEach(Array(filtered.enumerated()), id: \.element.id) { index, appt in
                            Button { onAppointmentTap(appt) } label: {
                                AppointmentCard(
                                    appointment: appt,
                                    remindMe: remindStates[appt.id] ?? false,
                                    onRemindToggle: { remindStates[appt.id]?.toggle() },

                                    // Cancel
                                    onCancel: {
                                        print("Appointment cancelled")
                                    },

                                    // Start Now
                                    onStartNow: {
                                        onStartNow(appt)
                                    },

                                    // Reschedule → go to doctor page
                                    onReschedule: {
                                        onReschedule(appt)
                                    },

                                    onReBook: {
                                        onReBook(appt)
                                    },

                                    onView: {
                                        onView(appt)
                                    },

                                    isFirstUpcoming: activeTab == .upcoming && index == 0
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                }
                .background(Color(hex: "#F4F6FB"))
            }
        }
        .background(Color(hex: "#F4F6FB"))
    }

    // ── Tab bar ────────────────────────────────────────────────────────────

    private var tabBar: some View {
        HStack(spacing: 0) {
            ForEach(AppointmentStatus.allCases, id: \.self) { tab in
                let isActive = tab == activeTab
                Button {
                    withAnimation(.easeInOut(duration: 0.2)) { activeTab = tab }
                } label: {
                    VStack(spacing: 0) {
                        Text(tab.rawValue)
                            .font(.system(size: 13, weight: isActive ? .bold : .medium))
                            .foregroundColor(isActive ? Color(hex: "#2196F3") : Color(hex: "#AAAAAA"))
                            .padding(.vertical, 10)
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
            Rectangle().fill(Color(hex: "#F0F0F5")).frame(height: 1)
        }
    }

    // ── Empty state ────────────────────────────────────────────────────────

    private var emptyState: some View {
        VStack(spacing: 14) {
            Spacer()
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 52))
                .foregroundColor(Color(hex: "#C8C8D0"))
            Text("No \(activeTab.rawValue) Appointments")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color(hex: "#888888"))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#F4F6FB"))
    }
}

#Preview {
    AppointmentsScreen()
}
