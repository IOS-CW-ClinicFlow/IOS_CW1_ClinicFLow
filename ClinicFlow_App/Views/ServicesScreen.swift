//
//  ServicesScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct ServicesScreen: View {

    var initialTab:    ServicesTab                   = .doctor
    var onBack:        () -> Void                    = {}
    var onDoctorTap:   (ServiceDoctor) -> Void       = { _ in }
    var onLabTap:      (ServicePlace)  -> Void       = { _ in }
    var onPharmacyTap: (ServicePlace)  -> Void       = { _ in }
    var onAppointment: (ServiceDoctor) -> Void       = { _ in }

    @State private var activeTab:        ServicesTab = .doctor
    @State private var showSearch:       Bool        = false
    @State private var searchText:       String      = ""
    @State private var showFilter:       Bool        = false
    @State private var selectedSpecialties: Set<String> = []
    @State private var showOpenOnly:     Bool        = false

    init(initialTab: ServicesTab = .doctor,
         onBack: @escaping () -> Void = {},
         onDoctorTap: @escaping (ServiceDoctor) -> Void = { _ in },
         onLabTap: @escaping (ServicePlace) -> Void = { _ in },
         onPharmacyTap: @escaping (ServicePlace) -> Void = { _ in },
         onAppointment: @escaping (ServiceDoctor) -> Void = { _ in }) {
        self.initialTab    = initialTab
        self.onBack        = onBack
        self.onDoctorTap   = onDoctorTap
        self.onLabTap      = onLabTap
        self.onPharmacyTap = onPharmacyTap
        self.onAppointment = onAppointment
        _activeTab = State(initialValue: initialTab)
    }

    // ── Derived filtered lists ─────────────────────────────────────────────

    private var filteredDoctors: [ServiceDoctor] {
        ServicesData.doctors.filter { doc in
            let matchesSearch = searchText.isEmpty
                || doc.name.localizedCaseInsensitiveContains(searchText)
                || doc.specialty.localizedCaseInsensitiveContains(searchText)
            let matchesSpecialty = selectedSpecialties.isEmpty
                || selectedSpecialties.contains(doc.specialty)
            return matchesSearch && matchesSpecialty
        }
    }

    private var filteredLabs: [ServicePlace] {
        ServicesData.labs.filter { lab in
            let matchesSearch = searchText.isEmpty
                || lab.name.localizedCaseInsensitiveContains(searchText)
                || lab.category.localizedCaseInsensitiveContains(searchText)
            let matchesOpen = !showOpenOnly || lab.isOpen
            return matchesSearch && matchesOpen
        }
    }

    private var filteredPharmacies: [ServicePlace] {
        ServicesData.pharmacies.filter { ph in
            let matchesSearch = searchText.isEmpty
                || ph.name.localizedCaseInsensitiveContains(searchText)
                || ph.category.localizedCaseInsensitiveContains(searchText)
            let matchesOpen = !showOpenOnly || ph.isOpen
            return matchesSearch && matchesOpen
        }
    }

    private var hasActiveFilters: Bool {
        !selectedSpecialties.isEmpty || showOpenOnly
    }

    // ── Body ───────────────────────────────────────────────────────────────

    var body: some View {
        VStack(spacing: 0) {

            topBar

            // Search bar
            if showSearch {
                searchBarView
                    .transition(.move(edge: .top).combined(with: .opacity))
            }

            tabBar

            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    switch activeTab {
                    case .doctor:
                        if filteredDoctors.isEmpty {
                            emptyState
                        } else {
                            ForEach(filteredDoctors) { doctor in
                                ServiceDoctorCard(
                                    doctor: doctor,
                                    onTap: { onDoctorTap(doctor) },
                                    onAppointment: { onAppointment(doctor) }
                                )
                            }
                        }
                    case .lab:
                        if filteredLabs.isEmpty {
                            emptyState
                        } else {
                            ForEach(filteredLabs) { lab in
                                ServicePlaceCard(place: lab, onTap: { onLabTap(lab) })
                            }
                        }
                    case .pharmacy:
                        if filteredPharmacies.isEmpty {
                            emptyState
                        } else {
                            ForEach(filteredPharmacies) { pharmacy in
                                ServicePlaceCard(place: pharmacy, onTap: { onPharmacyTap(pharmacy) })
                            }
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
        .onChange(of: activeTab) { _ in
            searchText = ""
            selectedSpecialties = []
            showOpenOnly = false
        }
        .sheet(isPresented: $showFilter) {
            filterSheet
        }
    }

    // ── Top bar ────────────────────────────────────────────────────────────

    private var topBar: some View {
        TopBar(
            title:         "Services",
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
    }

    // ── Inline search bar with filter button ───────────────────────────────

    private var searchBarView: some View {
        HStack(spacing: 9) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#BBBBCC"))
                TextField(activeTab == .doctor ? "Search by name or specialty" : "Search",
                          text: $searchText)
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

            // Filter button — red dot when active
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
            ForEach(ServicesTab.allCases, id: \.self) { tab in
                let isActive = tab == activeTab
                Button { activeTab = tab } label: {
                    VStack(spacing: 0) {
                        Text(tab.rawValue)
                            .font(.system(size: 14, weight: isActive ? .bold : .medium))
                            .foregroundColor(isActive ? Color(hex: "#2196F3") : Color(hex: "#999999"))
                            .padding(.vertical, 12)
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
            Rectangle().fill(Color(hex: "#F0F0F5")).frame(height: 1.5)
        }
    }

    // ── Empty state ────────────────────────────────────────────────────────

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 32))
                .foregroundColor(Color(hex: "#CCCCDD"))
            Text("No results found")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Color(hex: "#999999"))
            if hasActiveFilters {
                Button {
                    selectedSpecialties = []
                    showOpenOnly = false
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
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 60)
    }

    // ── Filter sheet ───────────────────────────────────────────────────────

    private var filterSheet: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Doctor specialty chips
                    if activeTab == .doctor {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Specialty")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Color(hex: "#1a1a1a"))

                            let specialties = Array(Set(ServicesData.doctors.map(\.specialty))).sorted()
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                                ForEach(specialties, id: \.self) { spec in
                                    let isOn = selectedSpecialties.contains(spec)
                                    Button {
                                        if isOn { selectedSpecialties.remove(spec) }
                                        else     { selectedSpecialties.insert(spec) }
                                    } label: {
                                        Text(spec)
                                            .font(.system(size: 13, weight: .semibold))
                                            .foregroundColor(isOn ? .white : Color(hex: "#555555"))
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 10)
                                            .background(isOn ? Color(hex: "#2196F3") : Color(hex: "#F4F6FB"))
                                            .clipShape(Capsule())
                                            .overlay(
                                                Capsule().stroke(
                                                    isOn ? Color.clear : Color(hex: "#E0E0EE"),
                                                    lineWidth: 1.5
                                                )
                                            )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }

                    // Open now toggle (for labs & pharmacies)
                    if activeTab == .lab || activeTab == .pharmacy {
                        Toggle(isOn: $showOpenOnly) {
                            Text("Open now only")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(hex: "#1a1a1a"))
                        }
                        .tint(Color(hex: "#2196F3"))
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
                        selectedSpecialties = []
                        showOpenOnly = false
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

#Preview("Doctor")   { ServicesScreen(initialTab: .doctor) }
#Preview("Lab")      { ServicesScreen(initialTab: .lab) }
#Preview("Pharmacy") { ServicesScreen(initialTab: .pharmacy) }
