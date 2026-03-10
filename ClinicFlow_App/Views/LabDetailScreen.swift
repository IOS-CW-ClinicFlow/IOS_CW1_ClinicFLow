//
//  LabDetailScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import SwiftUI

struct LabDetailScreen: View {

    let lab:    LabDetail
    var onBack: () -> Void = {}
    var onBook: (LabDetail, String, String) -> Void = { _, _, _ in }  // lab, date, time
    var onCall: () -> Void = {}
    var onMap:  () -> Void = {}

    @State private var selectedDay:  Int  = 0
    @State private var selectedTime: Int  = 0
    @State private var isFavourited: Bool = false
    @State private var showFullAbout: Bool = false

    private var selectedDate: String {
        lab.slots[selectedDay].date
    }
    private var selectedTimeStr: String {
        lab.times[selectedTime]
    }

    var body: some View {
        VStack(spacing: 0) {

            // ── Hero ───────────────────────────────────────────────────────
            LabHeroView(
                imageName:    lab.imageName,
                isFavourited: isFavourited,
                onBack:       onBack,
                onShare:      {},
                onFavourite:  { isFavourited.toggle() }
            )

            // ── Curved white card ──────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // Name row + action buttons
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
                            actionButton(iconName: "phone.fill", label: "Call",  action: onCall)
                            actionButton(iconName: "map.fill",   label: "Map",   action: onMap)
                        }
                    }
                    .padding(.bottom, 10)

                    // Location
                    Label(lab.location, systemImage: "mappin.circle.fill")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(hex: "#555555"))
                        .padding(.bottom, 4)

                    // Hours
                    Label(lab.hours, systemImage: "clock.fill")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(hex: "#555555"))
                        .padding(.bottom, 16)

                    // About
                    Text("About")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 5)

                    (
                        Text(showFullAbout ? lab.about : String(lab.about.prefix(80)) + "...")
                            .foregroundStyle(Color(hex: "#777777"))
                        +
                        Text(showFullAbout ? "" : " Read more")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(Color(hex: "#2196F3"))
                    )
                    .font(.system(size: 12))
                    .lineSpacing(4)
                    .onTapGesture { showFullAbout.toggle() }

                    // Chips
                    FlowLayout(spacing: 7) {
                        ForEach(lab.chips) { chip in
                            LabChipView(chip: chip)
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 18)

                    Divider().padding(.bottom, 16)

                    // BOOK APPOINTMENT section label
                    Text("BOOK APPOINTMENT")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(Color(hex: "#BBBBCC"))
                        .tracking(1.1)
                        .padding(.bottom, 12)

                    // Day picker
                    Text("Day")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 10)
                    LabDayPicker(slots: lab.slots, selectedIndex: $selectedDay)
                        .padding(.bottom, 18)

                    // Time picker
                    Text("Time")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 10)
                    LabTimePicker(times: lab.times, selectedIndex: $selectedTime)
                        .padding(.bottom, 20)

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
                    .padding(.bottom, 20)
                }
                .padding(.horizontal, 18)
                .padding(.top, 18)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .offset(y: -30)
            .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: -4)

            // ── Book Appointment CTA ───────────────────────────────────────
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(height: 1)

                Button {
                    onBook(lab, selectedDate, selectedTimeStr)
                } label: {
                    Text("Book Appointment")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color(hex: "#2196F3"))
                        .clipShape(Capsule())
                        .shadow(color: Color(hex: "#2196F3").opacity(0.4),
                                radius: 16, x: 0, y: 4)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 18)
                .padding(.vertical, 16)
            }
            .background(Color.white)
            .offset(y: -30)
        }
        .background(Color(hex: "#F4F6FB"))
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
                        .foregroundStyle(Color(hex: "#2196F3"))
                }
                Text(label)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color(hex: "#2196F3"))
            }
        }
        .buttonStyle(.plain)
    }
}

// ── Simple flow layout for chips ──────────────────────────────────────────────

private struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 0
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if x + size.width > width && x > 0 {
                x = 0; y += rowHeight + spacing; rowHeight = 0
            }
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }
        return CGSize(width: width, height: y + rowHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX
        var y = bounds.minY
        var rowHeight: CGFloat = 0
        for view in subviews {
            let size = view.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX && x > bounds.minX {
                x = bounds.minX; y += rowHeight + spacing; rowHeight = 0
            }
            view.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(size))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }
    }
}

#Preview {
    LabDetailScreen(lab: LabDetailData.xRay)
}
