//
//  LabDetailScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.

import SwiftUI

struct LabDetailScreen: View {

    let lab:    LabDetail
    var onBack: () -> Void = {}
    var onBook: (LabDetail, String, String) -> Void = { _, _, _ in }
    var onCall: () -> Void = {}
    var onMap:  () -> Void = {}

    @State private var selectedDay:   Int  = 0
    @State private var selectedTime:  Int  = 0
    @State private var isFavourited:  Bool = false
    @State private var showFullAbout: Bool = false

    private var selectedDate: String { lab.slots[selectedDay].date }
    private var selectedTimeStr: String { lab.times[selectedTime] }

    private var aboutText: Text {
        let preview = lab.about.truncatedAtWord(limit: 70)
        if showFullAbout {
            return Text(lab.about)
                .foregroundStyle(Color(hex: "#777777"))
        } else {
            return Text(preview + "... ")
                .foregroundStyle(Color(hex: "#777777"))
            + Text("Read more")
                .fontWeight(.semibold)
                .foregroundStyle(Color(hex: "#1A8FD1"))
        }
    }

    var body: some View {
        VStack(spacing: 0) {

            // ── Hero image with floating buttons ───────────────────────────
            HeroView(
                imageName:    lab.imageName,
                isFavourited: isFavourited,
                onBack:       onBack,
                onShare:      {},
                onFavourite:  { isFavourited.toggle() }
            )

            // ── White card curved top, overlapping hero ────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // Name + Call/Map
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(lab.name)
                                .font(.system(size: 18, weight: .heavy))
                                .foregroundStyle(Color(hex: "#1a1a1a"))
                                .tracking(-0.3)
                            Text(lab.subtitle)
                                .font(.system(size: 12))
                                .foregroundStyle(Color(hex: "#999999"))
                        }
                        Spacer()
                        HStack(spacing: 12) {
                            actionButton(iconName: "phone.fill", label: "Call", action: onCall)
                            actionButton(iconName: "map.fill",   label: "Map",  action: onMap)
                        }
                    }
                    .padding(.bottom, 12)

                    // Location
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color(hex: "#1A8FD1"))
                            .frame(width: 10, height: 10)
                        Text(lab.location)
                            .font(.system(size: 12))
                            .foregroundStyle(Color(hex: "#555555"))
                    }
                    .padding(.bottom, 5)

                    // Hours
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color(hex: "#2196F3"))
                            .frame(width: 10, height: 10)
                        Text(lab.hours)
                            .font(.system(size: 12))
                            .foregroundStyle(Color(hex: "#555555"))
                    }
                    .padding(.bottom, 16)

                    Divider().padding(.bottom, 15)

                    // About
                    Text("About")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 7)

                    aboutText
                        .font(.system(size: 12))
                        .lineSpacing(4)
                        .padding(.bottom, 12)
                        .onTapGesture { showFullAbout.toggle() }

                    // Chips
                    FlowLayout(hSpacing: 10, vSpacing: 14) {
                        ForEach(lab.chips) { chip in
                            LabChipView(chip: chip)
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 20)

                    Divider().padding(.bottom, 16)

                    // BOOK APPOINTMENT label
                    Text("BOOK APPOINTMENT")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(Color(hex: "#BBBBCC"))
                        .tracking(1.1)
                        .padding(.bottom, 14)

                    // Day picker
                    Text("Day")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 10)
                    LabDayPicker(slots: lab.slots, selectedIndex: $selectedDay)
                        .padding(.bottom, 20)

                    // Time picker
                    Text("Time")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 10)
                    LabTimePicker(times: lab.times, selectedIndex: $selectedTime)
                        .padding(.bottom, 24)

                    Divider().padding(.bottom, 16)

                    // Total Service Fee
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Total Service Fee")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(Color(hex: "#1a1a1a"))
                            Text("*This is the lab service fee only")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color(hex: "#F44336"))
                        }
                        Spacer()
                        Text(lab.serviceFee)
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundStyle(Color(hex: "#1a1a1a"))
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .background(Color(hex: "#EEF6FF"))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .padding(.bottom, 24)
                }
                .padding(.horizontal, 20)
                .padding(.top, 22)
                .padding(.bottom, 8)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
            .offset(y: -28)
            .padding(.bottom, -28)

            // ── Book Appointment CTA ───────────────────────────────────────
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(height: 1)

                PrimaryButton(title: "Book Appointment") {
                    onBook(lab, selectedDate, selectedTimeStr)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .background(Color.white)
        }
        .background(Color(hex: "#F0F4F8"))
        .ignoresSafeArea(edges: .top)
    }

    // ── Action button (Call / Map) ─────────────────────────────────────────
    @ViewBuilder
    private func actionButton(
        iconName: String,
        label: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            VStack(spacing: 3) {
                ZStack {
                    Circle()
                        .fill(Color(hex: "#E8F4FD"))
                        .frame(width: 40, height: 40)
                    Image(systemName: iconName)
                        .font(.system(size: 16))
                        .foregroundStyle(Color(hex: "#1A8FD1"))
                }
                Text(label)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color(hex: "#1A8FD1"))
            }
        }
        .buttonStyle(.plain)
    }
}

// ── Simple flow layout for chips ──────────────────────────────────────────────

private struct FlowLayout: Layout {
    var hSpacing: CGFloat = 8
    var vSpacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 0
        var x: CGFloat = 0, y: CGFloat = 0, rowHeight: CGFloat = 0
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if x + size.width > width && x > 0 { x = 0; y += rowHeight + vSpacing; rowHeight = 0 }
            rowHeight = max(rowHeight, size.height)
            x += size.width + hSpacing
        }
        return CGSize(width: width, height: y + rowHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX, y = bounds.minY, rowHeight: CGFloat = 0
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX && x > bounds.minX { x = bounds.minX; y += rowHeight + vSpacing; rowHeight = 0 }
            view.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
            rowHeight = max(rowHeight, size.height)
            x += size.width + hSpacing
        }
    }
}

// ── String helper ─────────────────────────────────────────────────────────────

extension String {
    func truncatedAtWord(limit: Int) -> String {
        guard count > limit else { return self }
        let truncated = prefix(limit)
        if truncated.last == " " {
            return String(truncated.dropLast())
        } else {
            return truncated.components(separatedBy: " ").dropLast().joined(separator: " ")
        }
    }
}

#Preview {
    LabDetailScreen(lab: LabDetailData.xRay)
}
