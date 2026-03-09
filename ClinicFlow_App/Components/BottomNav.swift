//
//  Bottomnav.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

private struct TabItem {
    let label: String
    let icon: String
    let iconFilled: String
}

private let tabs: [TabItem] = [
    TabItem(label: "Home",         icon: "house",           iconFilled: "house.fill"),
    TabItem(label: "Services",     icon: "square.grid.2x2", iconFilled: "square.grid.2x2.fill"),
    TabItem(label: "Appointments", icon: "calendar",        iconFilled: "calendar"),
    TabItem(label: "Map",          icon: "map",             iconFilled: "map.fill"),
    TabItem(label: "Profile",      icon: "person",          iconFilled: "person.fill"),
]

struct BottomNav: View {
    let activeTab: String
    var onTap: (String) -> Void = { _ in }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.label) { tab in
                let isActive = tab.label == activeTab
                Button { onTap(tab.label) } label: {
                    VStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(isActive ? Color(hex: "#2a9df4") : Color.clear)
                            .frame(width: 28, height: 3)
                        Image(systemName: isActive ? tab.iconFilled : tab.icon)
                            .font(.system(size: 22, weight: isActive ? .semibold : .regular))
                            .foregroundColor(isActive ? Color(hex: "#2a9df4") : Color(hex: "#aaaaaa"))
                        Text(tab.label)
                            .font(.system(size: 10, weight: isActive ? .semibold : .regular))
                            .foregroundColor(isActive ? Color(hex: "#2a9df4") : Color(hex: "#aaaaaa"))
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 6)
        .padding(.bottom, 24)
        .background(Color.white)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(Color(hex: "#f0f0f5"))
                .frame(height: 1)
        }
    }
}

#Preview {
    VStack {
        Spacer()
        BottomNav(activeTab: "Home") { print($0) }
    }
}
