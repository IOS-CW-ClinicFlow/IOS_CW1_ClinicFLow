//
//  HomeScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct HomeScreen: View {

    var onNotificationTap:  () -> Void                = {}
    var onSeeAllDoctors:    () -> Void                = {}
    var onSeeAllLabs:       () -> Void                = {}
    var onDoctorTap:        (Doctor) -> Void          = { _ in }
    var onLabTap:           (Lab) -> Void             = { _ in }
    var onCategoryTap:      (ServiceCategory) -> Void = { _ in }

    var body: some View {
        VStack(spacing: 0) {

            // ── Fixed header (status bar + location + search never scroll) ──
            headerSection

            // ── Only sections below search bar scroll ──────────────────────
            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    appointmentSection
                    categoriesSection
                    doctorsSection
                    labsSection
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
                    Text("Location")
                        .font(.system(size: 11))
                        .foregroundColor(Color(hex: "#aaaaaa"))
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#2a9df4"))
                        Text("Colombo")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(hex: "#1a1a1a"))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(Color(hex: "#555555"))
                    }
                }
                Spacer()
                HStack(spacing: 10) {

                    // ── Bell (perfectly centred + red dot) ────────────────
                    Button { onNotificationTap() } label: {
                        ZStack {
                            Circle()
                                .fill(Color(hex: "#F2F2F7"))
                                .frame(width: 38, height: 38)
                            Image(systemName: "bell.fill")
                                .font(.system(size: 16))
                                .foregroundColor(Color(hex: "#555555"))
                            // Red dot top-right
                            Circle()
                                .fill(Color(hex: "#F44336"))
                                .frame(width: 9, height: 9)
                                .overlay(Circle().stroke(Color(hex: "#F2F2F7"), lineWidth: 1.5))
                                .offset(x: 10, y: -10)
                        }
                    }
                    .buttonStyle(.plain)

                    // ── Language badge with dropdown ───────────────────────
                    LanguageBadge()
                }
            }

            // Search
            HStack(spacing: 9) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 15))
                        .foregroundColor(Color(hex: "#BBBBCC"))
                    Text("Search")
                        .font(.system(size: 14))
                        .foregroundColor(Color(hex: "#C8C8D0"))
                    Spacer()
                }
                .padding(.horizontal, 14)
                .frame(height: 44)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(hex: "#E8E8EE"), lineWidth: 1.5))

                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(hex: "#2196F3"))
                        .frame(width: 44, height: 44)
                        .shadow(color: Color(hex: "#2196F3").opacity(0.4), radius: 12, x: 0, y: 4)
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 10)
        .padding(.bottom, 16)
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
                Button("See All") {}
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color(hex: "#2196F3"))
            }
            .padding(.bottom, 12)

            VStack(spacing: 0) {
                HStack(spacing: 12) {
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 50, height: 50)
                        .overlay(Image(systemName: "person.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white.opacity(0.8)))
                        .overlay(Circle().stroke(Color.white.opacity(0.6), lineWidth: 2.5))

                    VStack(alignment: .leading, spacing: 3) {
                        Text("Dr. Nayanathara")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.white)
                        Text("Cardio Consultation")
                            .font(.system(size: 13))
                            .foregroundColor(.white.opacity(0.9))
                    }
                    Spacer()
                    ZStack {
                        Circle().fill(Color.white).frame(width: 44, height: 44)
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 2)
                        Image(systemName: "phone.fill")
                            .font(.system(size: 18))
                            .foregroundColor(Color(hex: "#2ECC88"))
                    }
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 16)

                HStack(spacing: 0) {
                    HStack(spacing: 7) {
                        Image(systemName: "calendar").font(.system(size: 13)).foregroundColor(.white)
                        Text("Monday, 25 Mar").font(.system(size: 13, weight: .medium)).foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    Rectangle().fill(Color.white.opacity(0.3)).frame(width: 1, height: 18)
                    HStack(spacing: 7) {
                        Image(systemName: "clock").font(.system(size: 13)).foregroundColor(.white)
                        Text("09:00 - 10:00").font(.system(size: 13, weight: .medium)).foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 18)
                .background(Color.black.opacity(0.18))
            }
            .background(Color(hex: "#2ECC88"))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: Color(hex: "#2ECC88").opacity(0.4), radius: 24, x: 0, y: 6)
        }
    }

    // ── Find What You Need ─────────────────────────────────────────────────

    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Find what you need")
                    .font(.system(size: 18, weight: .heavy))
                    .foregroundColor(Color(hex: "#1a1a1a"))
                Spacer()
                Button("See All") {}
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color(hex: "#2196F3"))
            }
            .padding(.bottom, 14)

            HStack(spacing: 0) {
                ForEach(ServiceCategory.allCases, id: \.self) { category in
                    Button { onCategoryTap(category) } label: {
                        VStack(spacing: 9) {
                            ZStack {
                                Circle()
                                    .fill(Color(hex: "#EAF4FE"))
                                    .frame(width: 66, height: 66)
                                Image(systemName: category.systemImage)
                                    .font(.system(size: 26))
                                    .foregroundColor(Color(hex: "#2196F3"))
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
                    .foregroundColor(Color(hex: "#1a1a1a"))
                Spacer()
                Button("See All", action: onSeeAllDoctors)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color(hex: "#2196F3"))
            }
            .padding(.bottom, 12)

            HStack(spacing: 12) {
                ForEach(HomeData.doctors) { doctor in
                    Button { onDoctorTap(doctor) } label: {
                        VStack(spacing: 0) {
                            ZStack(alignment: .bottomTrailing) {
                                Color(hex: doctor.backgroundColorHex).frame(height: 110)
                                Image(doctor.imageName)
                                    .resizable().scaledToFill()
                                    .frame(height: 110).clipped()
                                HStack(spacing: 3) {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 9))
                                        .foregroundColor(Color(hex: "#FFC107"))
                                    Text(String(format: "%.1f", doctor.rating))
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(Color(hex: "#333333"))
                                }
                                .padding(.vertical, 3).padding(.horizontal, 7)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(color: .black.opacity(0.18), radius: 4, x: 0, y: 1)
                                .padding(8)
                            }
                            .frame(height: 110).clipped()

                            VStack(alignment: .leading, spacing: 3) {
                                Text(doctor.name)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(Color(hex: "#1a1a1a"))
                                    .lineLimit(2)
                                Text(doctor.credentials)
                                    .font(.system(size: 10))
                                    .foregroundColor(Color(hex: "#aaaaaa"))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10).padding(.vertical, 9)
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 2)
                    }
                    .buttonStyle(.plain)
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
                    .foregroundColor(Color(hex: "#2196F3"))
            }
            .padding(.bottom, 12)

            HStack(spacing: 12) {
                ForEach(HomeData.labs) { lab in
                    Button { onLabTap(lab) } label: {
                        VStack(spacing: 0) {
                            ZStack(alignment: .bottomTrailing) {
                                Color(hex: "#D0E8F5").frame(height: 92)
                                Image(lab.imageName)
                                    .resizable().scaledToFill()
                                    .frame(height: 92).clipped()
                                HStack(spacing: 3) {
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 9))
                                        .foregroundColor(Color(hex: "#FFC107"))
                                    Text(String(format: "%.1f", lab.rating))
                                        .font(.system(size: 11, weight: .bold))
                                        .foregroundColor(Color(hex: "#333333"))
                                }
                                .padding(.vertical, 3).padding(.horizontal, 7)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(color: .black.opacity(0.18), radius: 4, x: 0, y: 1)
                                .padding(8)
                            }
                            .frame(height: 92).clipped()

                            VStack(alignment: .leading, spacing: 5) {
                                Text(lab.name)
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(Color(hex: "#1a1a1a"))
                                HStack(spacing: 5) {
                                    Circle().fill(Color(hex: "#2a9df4")).frame(width: 7, height: 7)
                                    Text("\(lab.waitTime) · \(lab.distance)")
                                        .font(.system(size: 11))
                                        .foregroundColor(Color(hex: "#888888"))
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 10).padding(.vertical, 9)
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 2)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    HomeScreen()
}
