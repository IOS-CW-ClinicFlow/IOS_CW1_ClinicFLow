//
//  AppointmentScreen.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct AppointmentsScreen: View {

    var onBack:           () -> Void            = {}
    var onAppointmentTap: (Appointment) -> Void = { _ in }
    var onStartNow:       (Appointment) -> Void = { _ in }
    var onReschedule:     (Appointment) -> Void = { _ in }
    var onReBook:         (Appointment) -> Void = { _ in }
    var onView:           (Appointment) -> Void = { _ in }

    @State private var activeTab:    AppointmentStatus = .upcoming
    @State private var showSearch:   Bool   = false
    @State private var searchText:   String = ""
    @State private var showFilter:   Bool   = false
    @State private var selectedDate: Date?  = nil
    @State private var selectedDoctors: Set<String> = []
    @State private var remindStates: [UUID: Bool] = {
        var dict: [UUID: Bool] = [:]
        AppointmentsData.appointments.forEach { dict[$0.id] = $0.remindMe }
        return dict
    }()

    private let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "MMM d, yyyy"   // matches "Mar 25, 2026"
        return f
    }()

    // ── Filtered list ──────────────────────────────────────────────────────

    private var tabAppointments: [Appointment] {
        AppointmentsData.appointments.filter { $0.status == activeTab }
    }

    private var filtered: [Appointment] {
        tabAppointments.filter { appt in
            let matchesSearch = searchText.isEmpty
                || appt.doctorName.localizedCaseInsensitiveContains(searchText)
                || appt.specialty.localizedCaseInsensitiveContains(searchText)
                || appt.date.localizedCaseInsensitiveContains(searchText)
            let matchesDate   = selectedDate == nil
                || appt.date == dateFormatter.string(from: selectedDate!)
            let matchesDoctor = selectedDoctors.isEmpty || selectedDoctors.contains(appt.doctorName)
            return matchesSearch && matchesDate && matchesDoctor
        }
    }

    private var hasActiveFilters: Bool { selectedDate != nil || !selectedDoctors.isEmpty }

    // ── Unique values for filter chips ────────────────────────────────────

    private var availableDoctors: [String] {
        DoctorDetailData.bySlug.values.map(\.name).sorted()
    }

    // ── Body ───────────────────────────────────────────────────────────────

    var body: some View {
        VStack(spacing: 0) {

            TopBar(
                title:          "My Appointments",
                showBack:       true,
                showSearch:     true,
                isSearchActive: showSearch,
                onBack:         onBack,
                onSearch: {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        showSearch.toggle()
                        if !showSearch { searchText = "" }
                    }
                }
            )

            if showSearch {
                searchBarView
                    .transition(.move(edge: .top).combined(with: .opacity))
            }

            tabBar

            if filtered.isEmpty {
                emptyState
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {
                        ForEach(Array(filtered.enumerated()), id: \.element.id) { index, appt in
                            AppointmentCard(
                                appointment: appt,
                                remindMe: remindStates[appt.id] ?? false,
                                onRemindToggle: { remindStates[appt.id]?.toggle() },
                                //onCardTap:   { onAppointmentTap(appt) },
                                onCancel:    { print("Appointment cancelled") },
                                onStartNow:  { onStartNow(appt) },
                                onReschedule:{ onReschedule(appt) },
                                onReBook:    { onReBook(appt) },
                                onView:      { onView(appt) },
                                isFirstUpcoming: activeTab == .upcoming && index == 0
                            )
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
        .onChange(of: activeTab) { _ in
            searchText = ""
            selectedDate = nil
            selectedDoctors = []
        }
        .sheet(isPresented: $showFilter) {
            filterSheet
        }
    }

    // ── Search bar ─────────────────────────────────────────────────────────

    private var searchBarView: some View {
        HStack(spacing: 9) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#BBBBCC"))
                TextField("Search by doctor, specialty or date", text: $searchText)
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#1a1a1a"))
                    .autocorrectionDisabled()
                if !searchText.isEmpty {
                    Button { searchText = "" } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(hex: "#BBBBCC"))
                            .font(.system(size: 14))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 14)
            .frame(height: 42)
            .background(Color(hex: "#F5F5FA"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "#EBEBF0"), lineWidth: 1))

            // Filter button
            Button { showFilter = true } label: {
                ZStack(alignment: .topTrailing) {
                    RoundedRectangle(cornerRadius: 11)
                        .fill(Color(hex: "#2196F3"))
                        .frame(width: 42, height: 42)
                        .shadow(color: Color(hex: "#2196F3").opacity(0.38), radius: 12, x: 0, y: 4)
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)
                    if hasActiveFilters {
                        Circle()
                            .fill(Color(hex: "#F44336"))
                            .frame(width: 9, height: 9)
                            .overlay(Circle().stroke(Color(hex: "#2196F3"), lineWidth: 1.5))
                            .offset(x: 2, y: -2)
                    }
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 12)
        .background(Color.white)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color(hex: "#F0F0F5")).frame(height: 1)
        }
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
            if hasActiveFilters || !searchText.isEmpty {
                Button {
                    selectedDate = nil
                    selectedDoctors = []
                    searchText = ""
                } label: {
                    Text("Clear Filters")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(hex: "#2196F3"))
                        .padding(.horizontal, 20).padding(.vertical, 8)
                        .background(Color(hex: "#EAF4FE"))
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#F4F6FB"))
    }

    // ── Filter sheet ───────────────────────────────────────────────────────

    private var filterSheet: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Doctor chips
                    if !availableDoctors.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Doctor")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Color(hex: "#1a1a1a"))
                            FlowLayout(hSpacing: 8, vSpacing: 10) {
                                ForEach(availableDoctors, id: \.self) { name in
                                    let isOn = selectedDoctors.contains(name)
                                    Button {
                                        if isOn { selectedDoctors.remove(name) }
                                        else    { selectedDoctors.insert(name) }
                                    } label: {
                                        Text(name)
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(isOn ? .white : Color(hex: "#555555"))
                                            .padding(.horizontal, 14).padding(.vertical, 8)
                                            .background(isOn ? Color(hex: "#2196F3") : Color(hex: "#F4F6FB"))
                                            .clipShape(Capsule())
                                            .overlay(Capsule().stroke(isOn ? Color.clear : Color(hex: "#E0E0EE"), lineWidth: 1.5))
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }

                    // Date — inline calendar
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Date")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Color(hex: "#1a1a1a"))
                            Spacer()
                            if selectedDate != nil {
                                Button("Clear") { selectedDate = nil }
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(Color(hex: "#F44336"))
                            }
                        }
                        DatePicker(
                            "",
                            selection: Binding(
                                get: { selectedDate ?? Date() },
                                set: { selectedDate = $0 }
                            ),
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .tint(Color(hex: "#2196F3"))
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }
                .padding(20)
            }
            .background(Color(hex: "#F4F6FB"))
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset") {
                        selectedDate = nil
                        selectedDoctors = []
                    }
                    .foregroundColor(Color(hex: "#F44336"))
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { showFilter = false }
                        .fontWeight(.bold)
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

// ── Flow layout for filter chips ──────────────────────────────────────────────

private struct FlowLayout: Layout {
    var hSpacing: CGFloat = 8
    var vSpacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 0
        var x: CGFloat = 0, y: CGFloat = 0, rowH: CGFloat = 0
        for v in subviews {
            let s = v.sizeThatFits(.unspecified)
            if x + s.width > width && x > 0 { x = 0; y += rowH + vSpacing; rowH = 0 }
            rowH = max(rowH, s.height); x += s.width + hSpacing
        }
        return CGSize(width: width, height: y + rowH)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX, y = bounds.minY, rowH: CGFloat = 0
        for v in subviews {
            let s = v.sizeThatFits(.unspecified)
            if x + s.width > bounds.maxX && x > bounds.minX { x = bounds.minX; y += rowH + vSpacing; rowH = 0 }
            v.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(s))
            rowH = max(rowH, s.height); x += s.width + hSpacing
        }
    }
}

#Preview { AppointmentsScreen() }
