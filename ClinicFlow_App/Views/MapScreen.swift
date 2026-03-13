//
//  MapScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-09.
//
import SwiftUI

// ── Multi-segment corridor path shape ────────────────────────────────────────

private struct CorridorPath: Shape {
    let points: [CGPoint]   // already in view-space coordinates

    func path(in rect: CGRect) -> Path {
        var p = Path()
        guard points.count >= 2 else { return p }
        p.move(to: points[0])
        for pt in points.dropFirst() { p.addLine(to: pt) }
        return p
    }
}

// ── Screen ────────────────────────────────────────────────────────────────────

struct MapScreen: View {

    var onBack: () -> Void = {}
    var initialSelectedPin: String? = nil
    
    @State private var selectedPin:      MapPin? = nil
    @State private var searchText:       String  = ""
    @State private var showDropdown:     Bool    = false
    @State private var selectedCategory: String  = "All"

    private let categories = ["All", "Ward", "Doctor", "Lab", "Emergency", "Services"]

    private var filteredPins: [MapPin] {
        MapData.pins.filter { pin in
            let matchesCategory: Bool = {
                switch selectedCategory {
                case "Ward":      return pin.label.localizedCaseInsensitiveContains("ward")
                                      || pin.label.localizedCaseInsensitiveContains("sharing")
                                      || pin.label.localizedCaseInsensitiveContains("icu")
                case "Doctor":    return pin.label.localizedCaseInsensitiveContains("doctor")
                                      || pin.label.localizedCaseInsensitiveContains("consult")
                                      || pin.label.localizedCaseInsensitiveContains("waiting")
                case "Lab":       return pin.label.localizedCaseInsensitiveContains("lab")
                                      || pin.label.localizedCaseInsensitiveContains("x-ray")
                                      || pin.label.localizedCaseInsensitiveContains("ct scan")
                case "Emergency": return pin.label.localizedCaseInsensitiveContains("emergency")
                                      || pin.label.localizedCaseInsensitiveContains("icu")
                                      || pin.label.localizedCaseInsensitiveContains("nurse")
                case "Services":  return pin.label.localizedCaseInsensitiveContains("reception")
                                      || pin.label.localizedCaseInsensitiveContains("registration")
                                      || pin.label.localizedCaseInsensitiveContains("pharmacy")
                                      || pin.label.localizedCaseInsensitiveContains("payment")
                                      || pin.label.localizedCaseInsensitiveContains("washroom")
                default:          return true
                }
            }()
            let matchesSearch = searchText.isEmpty
                || pin.label.localizedCaseInsensitiveContains(searchText)
            return matchesCategory && matchesSearch
        }
    }

    // ── Corridor path points helper ────────────────────────────────────────

    private func corridorPoints(for sel: MapPin, imageW: CGFloat, imageH: CGFloat, offsetX: CGFloat) -> [CGPoint] {
        func pt(_ x: Double, _ y: Double) -> CGPoint {
            CGPoint(x: offsetX + CGFloat(x) * imageW, y: CGFloat(y) * imageH)
        }
        let waypoints = WaypointGraph.path(from: "Waiting Hall", to: sel.label)
        var pts: [CGPoint] = [pt(MapData.currentPosition.x, MapData.currentPosition.y)]
        pts += waypoints.map { pt($0.x, $0.y) }
        pts.append(pt(sel.xRatio, sel.yRatio))
        return pts
    }

    var body: some View {
        VStack(spacing: 0) {

            TopBar(title: "Map", showBack: true, onBack: onBack)

            // ── Search + dropdown ──────────────────────────────────────────
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    searchBar
                    Rectangle().fill(Color(hex: "#F0F0F5")).frame(height: 1)
                }
                .zIndex(1)

                if showDropdown {
                    dropdownPanel
                        .padding(.top, 62)
                        .zIndex(2)
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }

            // ── Map ────────────────────────────────────────────────────────
            ZStack(alignment: .bottom) {
                MapCanvasView(
                    selectedPin:      selectedPin,
                    showDropdown:     $showDropdown,
                    corridorPointsFn: corridorPoints
                )
                .animation(.easeInOut(duration: 0.25), value: selectedPin?.label)

                // Dismiss / info bar overlay
                if let sel = selectedPin {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle().fill(sel.color.opacity(0.15)).frame(width: 40, height: 40)
                            Image(systemName: "mappin.circle.fill")
                                .font(.system(size: 20)).foregroundColor(sel.color)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text(sel.label)
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(Color(hex: "#1a1a1a"))
                            Text("\(sel.distance) · \(sel.time) walk")
                                .font(.system(size: 12)).foregroundColor(Color(hex: "#888888"))
                        }
                        Spacer()
                        Button {
                            withAnimation { selectedPin = nil; searchText = "" }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 22)).foregroundColor(Color(hex: "#CCCCCC"))
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 16).padding(.vertical, 14)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: .black.opacity(0.12), radius: 16, x: 0, y: -4)
                    .padding(.horizontal, 16).padding(.bottom, 16)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .background(Color(hex: "#F4F6FB"))
        .onAppear {
            if let slug = initialSelectedPin,
               let pin = MapData.pins.first(where: { $0.id == slug }) {
                selectedPin = pin
                searchText  = pin.label
            }
        }
    }

    // ── Search bar ─────────────────────────────────────────────────────────

    private var searchBar: some View {
        HStack(spacing: 9) {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#BBBBCC"))
                TextField("Search room, ward, department", text: $searchText)
                    .font(.system(size: 14))
                    .foregroundColor(Color(hex: "#1a1a1a"))
                    .autocorrectionDisabled()
                    .onTapGesture { withAnimation { showDropdown = true } }
                    .onChange(of: searchText) { _ in withAnimation { showDropdown = true } }
                if !searchText.isEmpty {
                    Button {
                        searchText = ""; selectedPin = nil
                    } label: {
                        Image(systemName: "xmark.circle.fill").foregroundColor(Color(hex: "#BBBBCC"))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 14).frame(height: 42)
            .background(Color(hex: "#F5F5FA"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(hex: "#EBEBF0"), lineWidth: 1))

            Button { withAnimation(.easeInOut(duration: 0.2)) { showDropdown.toggle() } } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 11)
                        .fill(Color(hex: "#2196F3"))
                        .frame(width: 42, height: 42)
                        .shadow(color: Color(hex: "#1A8FD1").opacity(0.38), radius: 12, x: 0, y: 4)
                    Image(systemName: "slider.horizontal.3")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)
                }
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 16).padding(.vertical, 10)
        .background(Color.white)
    }

    // ── Dropdown panel ─────────────────────────────────────────────────────

    private var dropdownPanel: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(categories, id: \.self) { cat in
                        let isOn = cat == selectedCategory
                        Button { selectedCategory = cat } label: {
                            Text(cat)
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(isOn ? .white : Color(hex: "#555555"))
                                .padding(.horizontal, 14).padding(.vertical, 7)
                                .background(isOn ? Color(hex: "#1A8FD1") : Color(hex: "#F4F6FB"))
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(isOn ? Color.clear : Color(hex: "#E0E0EE"), lineWidth: 1.5))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16).padding(.vertical, 10)
            }
            .background(Color.white)

            Divider()

            if filteredPins.isEmpty {
                HStack(spacing: 10) {
                    Image(systemName: "mappin.slash").foregroundColor(Color(hex: "#BBBBCC"))
                    Text("No locations found").font(.system(size: 14)).foregroundColor(Color(hex: "#AAAAAA"))
                }
                .padding(18).frame(maxWidth: .infinity).background(Color.white)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(filteredPins) { pin in
                            Button {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    selectedPin  = pin
                                    searchText   = pin.label
                                    showDropdown = false
                                }
                            } label: {
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle().fill(pin.color.opacity(0.15)).frame(width: 36, height: 36)
                                        Image(systemName: "mappin.fill")
                                            .font(.system(size: 14)).foregroundColor(pin.color)
                                    }
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(pin.label)
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(Color(hex: "#1a1a1a"))
                                        Text("\(pin.distance) · \(pin.time) walk")
                                            .font(.system(size: 12)).foregroundColor(Color(hex: "#888888"))
                                    }
                                    Spacer()
                                    if selectedPin?.label == pin.label {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(Color(hex: "#2196F3")).font(.system(size: 16))
                                    }
                                }
                                .padding(.horizontal, 16).padding(.vertical, 11)
                                .background(selectedPin?.label == pin.label ? Color(hex: "#EAF4FE") : Color.white)
                            }
                            .buttonStyle(.plain)
                            if pin.id != filteredPins.last?.id { Divider().padding(.leading, 64) }
                        }
                    }
                }
                .frame(maxHeight: 280)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.14), radius: 20, x: 0, y: 6)
        .padding(.horizontal, 16)
    }
}

// ── Map canvas — extracted so GeometryReader content isn't in a ViewBuilder ──

private struct MapCanvasView: View {
    let selectedPin:      MapPin?
    @Binding var showDropdown: Bool
    let corridorPointsFn: (MapPin, CGFloat, CGFloat, CGFloat) -> [CGPoint]

    var body: some View {
        GeometryReader { geo in
            let availW   = geo.size.width
            let availH   = geo.size.height
            let naturalH = availW * MapData.imageAspectRatio
            let imageH   = min(naturalH, availH)
            let imageW   = imageH / MapData.imageAspectRatio
            let offsetX  = (availW - imageW) / 2

            let youAreHere = CGPoint(
                x: offsetX + CGFloat(MapData.currentPosition.x) * imageW,
                y: CGFloat(MapData.currentPosition.y) * imageH
            )

            ZStack(alignment: .topLeading) {
                Color(hex: "#F4F6FB")

                Image("MapFloor1")
                    .resizable().scaledToFit()
                    .frame(width: imageW, height: imageH)
                    .offset(x: offsetX)

                // Corridor path
                if let sel = selectedPin {
                    let pts = corridorPointsFn(sel, imageW, imageH, offsetX)

                    CorridorPath(points: pts)
                        .stroke(sel.color.opacity(0.18),
                                style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))

                    CorridorPath(points: pts)
                        .stroke(sel.color,
                                style: StrokeStyle(lineWidth: 2.5, lineCap: .round,
                                                   lineJoin: .round, dash: [8, 5]))
                }

                // "You are here" dot
                ZStack {
                    Circle().fill(Color(hex: "#1A8FD1").opacity(0.2)).frame(width: 22, height: 22)
                    Circle().fill(Color(hex: "#1A8FD1")).frame(width: 12, height: 12)
                    Circle().fill(Color.white).frame(width: 5, height: 5)
                }
                .position(youAreHere)

                // Destination dot + label
                if let sel = selectedPin {
                    let destX = offsetX + CGFloat(sel.xRatio) * imageW
                    let destY = CGFloat(sel.yRatio) * imageH

                    ZStack {
                        Circle().fill(sel.color.opacity(0.25)).frame(width: 26, height: 26)
                        Circle().fill(sel.color).frame(width: 14, height: 14)
                        Circle().fill(Color.white).frame(width: 6, height: 6)
                    }
                    .position(x: destX, y: destY)

                    Text(sel.label)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(Color(hex: "#1a1a1a"))
                        .padding(.horizontal, 10).padding(.vertical, 5)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 2)
                        .position(x: destX, y: destY - 26)
                }

                // Bottom info bar lives in MapScreen overlay
            }
            .frame(width: availW, height: availH)
            .contentShape(Rectangle())
            .onTapGesture { withAnimation { showDropdown = false } }
        }
    }
}

#Preview { MapScreen() }
