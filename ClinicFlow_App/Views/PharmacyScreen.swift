//
//  PharmacyScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-11.
//
import SwiftUI

struct PharmacyScreen: View {

    let pharmacy:   PharmacyDetail
    var onBack:     () -> Void = {}
    var onOrder:    (PharmacyDetail) -> Void = { _ in }
    var onCall:     () -> Void = {}
    var onMap:      () -> Void = {}

    @State private var isFavourited:  Bool = false
    @State private var showFullAbout: Bool = false
    @State private var hasFile:       Bool = false

    private var aboutText: Text {
        let preview = pharmacy.about.truncatedAtWord(limit: 70)
        if showFullAbout {
            return Text(pharmacy.about).foregroundStyle(Color(hex: "#777777"))
        } else {
            return Text(preview + "... ").foregroundStyle(Color(hex: "#777777"))
                + Text("Read more").fontWeight(.semibold).foregroundStyle(Color(hex: "#1A8FD1"))
        }
    }

    var body: some View {
        VStack(spacing: 0) {

            // ── Hero ───────────────────────────────────────────────────────
            HeroView(
                imageName:    pharmacy.imageName,
                isFavourited: isFavourited,
                onBack:       onBack,
                onShare:      {},
                onFavourite:  { isFavourited.toggle() }
            )

            // ── White card curved top ──────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // Name + Call/Map
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(pharmacy.name)
                                .font(.system(size: 17, weight: .heavy))
                                .foregroundStyle(Color(hex: "#1a1a1a"))
                                .tracking(-0.3)
                            Text(pharmacy.subtitle)
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
                        MapPinCircleIcon(size: 12)
                        Text(pharmacy.location)
                            .font(.system(size: 12))
                            .foregroundStyle(Color(hex: "#555555"))
                    }
                    .padding(.bottom, 5)

                    // Hours
                    HStack(spacing: 8) {
                        Image(systemName: "clock.fill")
                                .font(.system(size: 12))
                                .foregroundStyle(Color(hex: "#1A8FD1"))
                        Text(pharmacy.hours)
                            .font(.system(size: 12))
                            .foregroundStyle(Color(hex: "#555555"))
                    }
                    .padding(.bottom, 18)

                    Divider().padding(.bottom, 15)

                    // About
                    Text("About")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 7)

                    aboutText
                        .font(.system(size: 12))
                        .lineSpacing(4)
                        .onTapGesture { showFullAbout.toggle() }
                        .padding(.bottom, 12)

                    // Chips
                    FlowLayout(spacing: 10) {
                        ForEach(pharmacy.badges) { chip in
                            PharmacyChipView(chip: chip)
                        }
                    }
                    .padding(.bottom, 20)

                    Divider().padding(.bottom, 16)

                    // ORDER MY PRESCRIPTION label
                    Text("ORDER MY PRESCRIPTION")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(Color(hex: "#BBBBCC"))
                        .tracking(1.1)
                        .padding(.bottom, 10)

                    Text("Upload your prescription")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 14)

                    PrescriptionUploadBox(hasFile: $hasFile)
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

            // ── Order Prescription CTA ─────────────────────────────────────
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(height: 1)

                PrimaryButton(title: "Order Prescription") { onOrder(pharmacy) }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 32)
            }
            .background(Color.white)
        }
        .background(Color(hex: "#F0F4F8"))
        .ignoresSafeArea(edges: .top)
    }

    @ViewBuilder
    private func actionButton(iconName: String, label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 3) {
                ZStack {
                    Circle().fill(Color(hex: "#E8F4FD")).frame(width: 40, height: 40)
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

// ── Flow layout (same as LabDetailScreen) ─────────────────────────────────────

private struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let width = proposal.width ?? 0
        var x: CGFloat = 0, y: CGFloat = 0, rowH: CGFloat = 0
        for v in subviews {
            let s = v.sizeThatFits(.unspecified)
            if x + s.width > width && x > 0 { x = 0; y += rowH + spacing; rowH = 0 }
            rowH = max(rowH, s.height); x += s.width + spacing
        }
        return CGSize(width: width, height: y + rowH)
    }
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var x = bounds.minX, y = bounds.minY, rowH: CGFloat = 0
        for v in subviews {
            let s = v.sizeThatFits(.unspecified)
            if x + s.width > bounds.maxX && x > bounds.minX { x = bounds.minX; y += rowH + spacing; rowH = 0 }
            v.place(at: CGPoint(x: x, y: y), proposal: ProposedViewSize(s))
            rowH = max(rowH, s.height); x += s.width + spacing
        }
    }
}

#Preview { PharmacyScreen(pharmacy: PharmacyData.clinicFlow) }
