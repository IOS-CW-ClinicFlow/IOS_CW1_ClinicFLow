////
////  MapScreen.swift
////  ClinicFlow_App
////
////  Created by COBSCCOMP24.2P-019 on 2026-03-09.
////
////
////
//import SwiftUI
//
//// ── Dotted path shape ─────────────────────────────────────────────────────────
//
//private struct DottedPath: Shape {
//    let from: CGPoint
//    let to: CGPoint
//    func path(in rect: CGRect) -> Path {
//        var p = Path()
//        p.move(to: from)
//        p.addLine(to: to)
//        return p
//    }
//}
//
//// ── Screen ────────────────────────────────────────────────────────────────────
//
//struct MapScreen: View {
//
//    var onBack: () -> Void = {}
//    @State private var selectedLabel: String = ""
//
//    var body: some View {
//        VStack(spacing: 0) {
//
//            // ── Title bar ──────────────────────────────────────────────────
//            topBar
//
//            // ── Always-visible search bar ──────────────────────────────────
//            SearchBar(placeholder: "Search Doctor, Hospital")
//
//            // ── GeometryReader gets exact remaining space ──────────────────
//            GeometryReader { geo in
//                let availW = geo.size.width
//                let availH = geo.size.height
//
//                let naturalH = availW * MapData.imageAspectRatio
//                let imageH   = min(naturalH, availH)
//                let imageW   = imageH / MapData.imageAspectRatio
//                let offsetX  = (availW - imageW) / 2
//
//                ZStack(alignment: .topLeading) {
//
//                    Color(hex: "#F4F6FB")
//
//                    // Floor plan
//                    Image("MapFloor1")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: imageW, height: imageH)
//                        .offset(x: offsetX)
//
//                    // Dotted path to selected pin
//                    if let sel = MapData.pins.first(where: { $0.label == selectedLabel }) {
//                        DottedPath(
//                            from: CGPoint(x: offsetX + MapData.currentPosition.x * imageW,
//                                          y: MapData.currentPosition.y * imageH),
//                            to:   CGPoint(x: offsetX + sel.xRatio * imageW,
//                                          y: sel.yRatio * imageH)
//                        )
//                        .stroke(sel.color, style: StrokeStyle(lineWidth: 2.5, dash: [8, 5]))
//                        .animation(.easeInOut, value: selectedLabel)
//                    }
//
//                    // "You are here" dot
//                    ZStack {
//                        Circle().fill(Color(hex: "#2196F3").opacity(0.2)).frame(width: 22, height: 22)
//                        Circle().fill(Color(hex: "#2196F3")).frame(width: 12, height: 12)
//                        Circle().fill(Color.white).frame(width: 5, height: 5)
//                    }
//                    .position(x: offsetX + MapData.currentPosition.x * imageW,
//                               y: MapData.currentPosition.y * imageH)
//
//                    // Pins
//                    ForEach(MapData.pins) { pin in
//                        MapPinView(
//                            color:         pin.color,
//                            hasDot:        pin.hasDot,
//                            pulsing:       pin.pulsing,
//                            label:         pin.label,
//                            distance:      pin.distance,
//                            time:          pin.time,
//                            selectedLabel: $selectedLabel
//                        )
//                        .position(x: offsetX + pin.xRatio * imageW,
//                                   y: pin.yRatio * imageH)
//                    }
//                }
//                .frame(width: availW, height: availH)
//                .contentShape(Rectangle())
//                .onTapGesture { withAnimation { selectedLabel = "" } }
//            }
//        }
//        .background(Color(hex: "#F4F6FB"))
//    }
//
//    // ── Top bar ────────────────────────────────────────────────────────────
//
//    private var topBar: some View {
//        TopBar(title: "Map", showBack: true, onBack: onBack)
//    }
//}
//
//#Preview {
//    MapScreen()
//}

//
//  MapScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-09.
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

    @State private var selectedLabel:    String = ""
    @State private var searchText:       String = ""
    @State private var showSuggestions:  Bool   = false
    @State private var selectedCategory: String = "All"

    private let categories = ["All", "Ward", "Doctor", "Waiting", "Other"]

    private var filteredPins: [MapPin] {
        MapData.pins.filter { pin in
            switch selectedCategory {
            case "Ward":    return pin.label.localizedCaseInsensitiveContains("ward")
            case "Doctor":  return pin.label.localizedCaseInsensitiveContains("doctor")
            case "Waiting": return pin.label.localizedCaseInsensitiveContains("wait")
            case "Other":   return !pin.label.localizedCaseInsensitiveContains("ward")
                                && !pin.label.localizedCaseInsensitiveContains("doctor")
                                && !pin.label.localizedCaseInsensitiveContains("wait")
            default:        return true
            }
        }
    }

    // ── Search results: pins whose label matches ───────────────────────────
    private var suggestions: [MapPin] {
        guard !searchText.isEmpty else { return [] }
        return MapData.pins.filter {
            $0.label.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        VStack(spacing: 0) {

            TopBar(title: "Map", showBack: true, onBack: onBack)

            // ── Search bar ─────────────────────────────────────────────────
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    HStack(spacing: 9) {
                        HStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#BBBBCC"))
                            TextField("Search room, ward, department", text: $searchText)
                                .font(.system(size: 14))
                                .foregroundColor(Color(hex: "#1a1a1a"))
                                .onChange(of: searchText) { _ in
                                    showSuggestions = !searchText.isEmpty
                                }
                            if !searchText.isEmpty {
                                Button {
                                    searchText = ""
                                    showSuggestions = false
                                    withAnimation { selectedLabel = "" }
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(Color(hex: "#BBBBCC"))
                                }
                            }
                        }
                        .padding(.horizontal, 14)
                        .frame(height: 42)
                        .background(Color(hex: "#F5F5FA"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "#EBEBF0"), lineWidth: 1))
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                    .padding(.bottom, showSuggestions ? 4 : 12)
                    .background(Color.white)

                    // ── Suggestions dropdown ───────────────────────────────
                    if showSuggestions {
                        VStack(spacing: 0) {
                            if suggestions.isEmpty {
                                HStack(spacing: 10) {
                                    Image(systemName: "mappin.slash")
                                        .foregroundColor(Color(hex: "#BBBBCC"))
                                    Text("No locations found")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(hex: "#AAAAAA"))
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 14)
                            } else {
                                ForEach(suggestions) { pin in
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            selectedLabel = pin.label
                                        }
                                        searchText      = pin.label
                                        showSuggestions = false
                                    } label: {
                                        HStack(spacing: 12) {
                                            ZStack {
                                                Circle().fill(pin.color.opacity(0.15)).frame(width: 34, height: 34)
                                                Image(systemName: "mappin.fill")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(pin.color)
                                            }
                                            VStack(alignment: .leading, spacing: 2) {
                                                Text(pin.label)
                                                    .font(.system(size: 14, weight: .semibold))
                                                    .foregroundColor(Color(hex: "#1a1a1a"))
                                                Text("\(pin.distance) · \(pin.time) walk")
                                                    .font(.system(size: 12))
                                                    .foregroundColor(Color(hex: "#888888"))
                                            }
                                            Spacer()
                                        }
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 11)
                                    }
                                    .buttonStyle(.plain)
                                    if pin.id != suggestions.last?.id { Divider().padding(.leading, 62) }
                                }
                            }
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 4)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 8)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1)
                    }

                    Rectangle().fill(Color(hex: "#F0F0F5")).frame(height: 1)

                    // ── Category filter chips ──────────────────────────────
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(categories, id: \.self) { cat in
                                let isOn = cat == selectedCategory
                                Button { selectedCategory = cat } label: {
                                    Text(cat)
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundColor(isOn ? .white : Color(hex: "#555555"))
                                        .padding(.horizontal, 14).padding(.vertical, 7)
                                        .background(isOn ? Color(hex: "#2196F3") : Color(hex: "#F4F6FB"))
                                        .clipShape(Capsule())
                                        .overlay(Capsule().stroke(isOn ? Color.clear : Color(hex: "#E0E0EE"), lineWidth: 1.5))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 16).padding(.vertical, 10)
                    }
                    .background(Color.white)
                    .overlay(alignment: .bottom) {
                        Rectangle().fill(Color(hex: "#F0F0F5")).frame(height: 1)
                    }
                }
                .zIndex(1)
            }

            // ── Map ────────────────────────────────────────────────────────
            GeometryReader { geo in
                let availW = geo.size.width
                let availH = geo.size.height
                let naturalH = availW * MapData.imageAspectRatio
                let imageH   = min(naturalH, availH)
                let imageW   = imageH / MapData.imageAspectRatio
                let offsetX  = (availW - imageW) / 2

                ZStack(alignment: .topLeading) {
                    Color(hex: "#F4F6FB")

                    Image("MapFloor1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageW, height: imageH)
                        .offset(x: offsetX)

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

                    // "You are here"
                    ZStack {
                        Circle().fill(Color(hex: "#2196F3").opacity(0.2)).frame(width: 22, height: 22)
                        Circle().fill(Color(hex: "#2196F3")).frame(width: 12, height: 12)
                        Circle().fill(Color.white).frame(width: 5, height: 5)
                    }
                    .position(x: offsetX + MapData.currentPosition.x * imageW,
                               y: MapData.currentPosition.y * imageH)

                    ForEach(filteredPins) { pin in
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
                .onTapGesture {
                    withAnimation { selectedLabel = "" }
                    showSuggestions = false
                }
            }
        }
        .background(Color(hex: "#F4F6FB"))
    }
}

#Preview { MapScreen() }
