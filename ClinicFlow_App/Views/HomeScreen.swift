//  HomeScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct HomeScreen: View {

    var onNotificationTap:    () -> Void                = {}
    var onSeeAllDoctors:      () -> Void                = {}
    var onSeeAllLabs:         () -> Void                = {}
    var onSeeAllAppointments: () -> Void                = {}
    var onViewAppointment:    () -> Void                = {}
    var onCallTap:            () -> Void                = {}
    var onDoctorTap:      (Doctor) -> Void          = { _ in }
    var onLabTap:         (Lab) -> Void             = { _ in }
    var onCategoryTap:    (ServiceCategory) -> Void = { _ in }

    @State private var searchText: String = ""

    // ── Filtered doctors & labs ────────────────────────────────────────────
    private var filteredDoctors: [Doctor] {
        guard !searchText.isEmpty else { return HomeData.doctors }
        // Match against HomeData but also show doctors from DoctorDetailData
        // by converting DoctorDetail entries to Doctor for display
        let homeMatches = HomeData.doctors.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.credentials.localizedCaseInsensitiveContains(searchText)
        }
        let detailMatches = DoctorDetailData.bySlug.values
            .filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.specialty.localizedCaseInsensitiveContains(searchText)
            }
            .compactMap { detail -> Doctor? in
                // Only add if not already in homeMatches
                guard !homeMatches.contains(where: { $0.name == detail.name }) else { return nil }
                return Doctor(
                    name: detail.name,
                    credentials: detail.specialty,
                    rating: Double(detail.rating.replacingOccurrences(of: "+", with: "")) ?? 4.8,
                    imageName: detail.avatarName,
                    backgroundColorHex: "#D6EAF8",
                    slug: DoctorDetailData.bySlug.first(where: { $0.value.name == detail.name })?.key ?? ""
                )
            }
        return homeMatches + detailMatches
    }

    private var filteredLabs: [Lab] {
        guard !searchText.isEmpty else { return HomeData.labs }
        return HomeData.labs.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            headerSection

            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    if searchText.isEmpty {
                        appointmentSection
                        categoriesSection
                    }
                    doctorsSection
                    labsSection

                    if !searchText.isEmpty && filteredDoctors.isEmpty && filteredLabs.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 40))
                                .foregroundColor(Color(hex: "#C8C8D0"))
                            Text("No results for \"\(searchText)\"")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(Color(hex: "#888888"))
                        }
                        .padding(.top, 40)
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

    // ── Header ─────────────────────────────────────────────────────────────
    private var headerSection: some View {
        VStack(spacing: 12) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Welcome 👋")
                        .font(.system(size: 13))
                        .foregroundColor(Color(hex: "#aaaaaa"))
                    Text("Hi, Sandun!")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                }
                Spacer()
                HStack(spacing: 10) {
                    Button { onNotificationTap() } label: {
                        ZStack {
                            Circle().fill(Color(hex: "#F2F2F7")).frame(width: 38, height: 38)
                            Image(systemName: "bell.fill").font(.system(size: 16)).foregroundColor(Color(hex: "#555555"))
                            Circle().fill(Color(hex: "#F44336")).frame(width: 9, height: 9)
                                .overlay(Circle().stroke(Color(hex: "#F2F2F7"), lineWidth: 1.5))
                                .offset(x: 7, y: -7)
                        }
                    }
                    .buttonStyle(.plain)
                    LanguageBadge()
                }
            }
            .padding(.horizontal, 18)

            SearchBar(placeholder: "Search Doctors, Labs, Services", text: $searchText)
        }
        .padding(.top, 10)
        .background(Color.white)
    }

    // ── Current Appointment ────────────────────────────────────────────────
    private var appointmentSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Current Appointment")
                    .font(.system(size: 18, weight: .heavy))
                    .foregroundColor(Color(hex: "#1a1a1a"))
                Spacer()
                Button("See All") { onSeeAllAppointments() }
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color(hex: "#1A8FD1"))
            }
            .padding(.bottom, 12)

            Button { onViewAppointment() } label: {
                VStack(spacing: 0) {
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 50, height: 50)
                            .overlay(Image("doc1")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        )
                            .overlay(Circle().stroke(Color.white.opacity(0.6), lineWidth: 2.5))
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Dr. Nayanathara").font(.system(size: 16, weight: .heavy)).foregroundColor(.white)
                            Text("Cardio Consultation").font(.system(size: 13)).foregroundColor(.white.opacity(0.9))
                        }
                        Spacer()
                        Button { onCallTap() } label: {
                            ZStack {
                                Circle().fill(Color.white).frame(width: 44, height: 44)
                                    .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 2)
                                Image(systemName: "phone.fill").font(.system(size: 18)).foregroundColor(Color(hex: "#2ECC88"))
                            }
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 18).padding(.vertical, 16)

                    HStack(spacing: 0) {
                        HStack(spacing: 7) {
                            Image(systemName: "calendar").font(.system(size: 13)).foregroundColor(.white)
                            Text("Monday, 25 Mar").font(.system(size: 13, weight: .medium)).foregroundColor(.white)
                        }.frame(maxWidth: .infinity)
                        Rectangle().fill(Color.white.opacity(0.3)).frame(width: 1, height: 18)
                        HStack(spacing: 7) {
                            Image(systemName: "clock").font(.system(size: 13)).foregroundColor(.white)
                            Text("09:00 - 10:00").font(.system(size: 13, weight: .medium)).foregroundColor(.white)
                        }.frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 12).padding(.horizontal, 18)
                    .background(Color.black.opacity(0.18))
                }
                .background(Color(hex: "#2ECC88"))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color(hex: "#2ECC88").opacity(0.4), radius: 24, x: 0, y: 6)
            }
            .buttonStyle(.plain)
        }
    }

    // ── Categories ─────────────────────────────────────────────────────────
    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Find what you need")
                .font(.system(size: 18, weight: .heavy))
                .foregroundColor(Color(hex: "#1a1a1a"))
                .padding(.bottom, 14)

            HStack(spacing: 0) {
                ForEach(ServiceCategory.allCases, id: \.self) { category in
                    Button { onCategoryTap(category) } label: {
                        VStack(spacing: 9) {
                            ZStack {
                                Circle().fill(Color(hex: "#DCEEFF")).frame(width: 66, height: 66)
                                Image(systemName: category.systemImage)
                                    .font(.system(size: 26))
                                    .foregroundColor(Color(hex: "#1A8FD1"))
                            }
                            Text(category.rawValue)
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(Color(hex: "#333333"))
                        }
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }

    // ── Today's Doctors ────────────────────────────────────────────────────
    private var doctorsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Today's Doctors")
                    .font(.system(size: 18, weight: .heavy))
                    .foregroundStyle(Color(hex: "#1a1a1a"))
                Spacer()
                Button("See All", action: onSeeAllDoctors)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color(hex: "#1A8FD1"))
            }
            .padding(.bottom, 12)

            if filteredDoctors.isEmpty {
                Text("No doctors match \"\(searchText)\"")
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "#AAAAAA"))
                    .padding(.vertical, 8)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(filteredDoctors) { doctor in
                            Button { onDoctorTap(doctor) } label: {
                                ClinicCardView(
                                    title:         doctor.name,
                                    subtitle:      doctor.credentials,
                                    info:          nil,
                                    imageName:     doctor.imageName,
                                    backgroundHex: doctor.backgroundColorHex,
                                    rating:        doctor.rating
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.bottom, 4)
                }
            }
        }
    }

    // ── Labs ───────────────────────────────────────────────────────────────
    private var labsSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Labs")
                    .font(.system(size: 18, weight: .heavy))
                    .foregroundColor(Color(hex: "#1a1a1a"))
                Spacer()
                Button("See All", action: onSeeAllLabs)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color(hex: "#1A8FD1"))
            }
            .padding(.bottom, 12)

            if filteredLabs.isEmpty {
                Text("No labs match \"\(searchText)\"")
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: "#AAAAAA"))
                    .padding(.vertical, 8)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(filteredLabs) { lab in
                            Button { onLabTap(lab) } label: {
                                ClinicCardView(
                                    title:         lab.name,
                                    subtitle:      nil,
                                    info:          "\(lab.waitTime) · \(lab.distance)",
                                    imageName:     lab.imageName,
                                    backgroundHex: "#D0E8F5",
                                    rating:        lab.rating
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.bottom, 4)
                }
            }
        }
    }
}

#Preview { HomeScreen() }
