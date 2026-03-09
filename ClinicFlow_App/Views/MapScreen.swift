//
//  MapScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-09.
//
//
//
import SwiftUI

// ── Dotted path shape ─────────────────────────────────────────────────────────

private struct DottedPath: Shape {
    let from: CGPoint
    let to: CGPoint
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: from)
        p.addLine(to: to)
        return p
    }
}

// ── Screen ────────────────────────────────────────────────────────────────────

struct MapScreen: View {

    var onBack: () -> Void = {}
    @State private var selectedLabel: String = ""

    var body: some View {
        VStack(spacing: 0) {

            // ── Title bar ──────────────────────────────────────────────────
            topBar

            // ── Always-visible search bar ──────────────────────────────────
            SearchBar(placeholder: "Search Doctor, Hospital")

            // ── GeometryReader gets exact remaining space ──────────────────
            GeometryReader { geo in
                let availW = geo.size.width
                let availH = geo.size.height

                let naturalH = availW * MapData.imageAspectRatio
                let imageH   = min(naturalH, availH)
                let imageW   = imageH / MapData.imageAspectRatio
                let offsetX  = (availW - imageW) / 2

                ZStack(alignment: .topLeading) {

                    Color(hex: "#F4F6FB")

                    // Floor plan
                    Image("MapFloor1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageW, height: imageH)
                        .offset(x: offsetX)

                    // Dotted path to selected pin
                    if let sel = MapData.pins.first(where: { $0.label == selectedLabel }) {
                        DottedPath(
                            from: CGPoint(x: offsetX + MapData.currentPosition.x * imageW,
                                          y: MapData.currentPosition.y * imageH),
                            to:   CGPoint(x: offsetX + sel.xRatio * imageW,
                                          y: sel.yRatio * imageH)
                        )
                        .stroke(sel.color, style: StrokeStyle(lineWidth: 2.5, dash: [8, 5]))
                        .animation(.easeInOut, value: selectedLabel)
                    }

                    // "You are here" dot
                    ZStack {
                        Circle().fill(Color(hex: "#2196F3").opacity(0.2)).frame(width: 22, height: 22)
                        Circle().fill(Color(hex: "#2196F3")).frame(width: 12, height: 12)
                        Circle().fill(Color.white).frame(width: 5, height: 5)
                    }
                    .position(x: offsetX + MapData.currentPosition.x * imageW,
                               y: MapData.currentPosition.y * imageH)

                    // Pins
                    ForEach(MapData.pins) { pin in
                        MapPinView(
                            color:         pin.color,
                            hasDot:        pin.hasDot,
                            pulsing:       pin.pulsing,
                            label:         pin.label,
                            distance:      pin.distance,
                            time:          pin.time,
                            selectedLabel: $selectedLabel
                        )
                        .position(x: offsetX + pin.xRatio * imageW,
                                   y: pin.yRatio * imageH)
                    }
                }
                .frame(width: availW, height: availH)
                .contentShape(Rectangle())
                .onTapGesture { withAnimation { selectedLabel = "" } }
            }
        }
        .background(Color(hex: "#F4F6FB"))
    }

    // ── Top bar ────────────────────────────────────────────────────────────

    private var topBar: some View {
        TopBar(title: "Map", showBack: true, onBack: onBack)
    }
}

#Preview {
    MapScreen()
}
