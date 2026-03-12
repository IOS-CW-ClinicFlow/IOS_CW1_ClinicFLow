//
//  LabSlotPicker.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
//
//  LabSlotPicker.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-10.
//
import SwiftUI

struct LabDayPicker: View {
    let slots: [LabSlot]
    @Binding var selectedIndex: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Array(slots.enumerated()), id: \.element.id) { index, slot in
                    Button {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            selectedIndex = index
                        }
                    } label: {
                        VStack(spacing: 2) {
                            Text(slot.day)
                                .font(.system(size: 10, weight: .semibold))
                            Text(slot.date)
                                .font(.system(size: 12, weight: .bold))
                        }
                        .foregroundStyle(selectedIndex == index ? Color.white : Color(hex: "#555555"))
                        .padding(.horizontal, 18)
                        .padding(.vertical, 11)
                        .background(selectedIndex == index ? Color(hex: "#2196F3") : Color(hex: "#F4F6FB"))
                        .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.bottom, 4)
        }
    }
}

struct LabTimePicker: View {
    let times: [String]
    @Binding var selectedIndex: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Array(times.enumerated()), id: \.offset) { index, time in
                    Button {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            selectedIndex = index
                        }
                    } label: {
                        Text(time)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(selectedIndex == index ? Color.white : Color(hex: "#555555"))
                            .padding(.horizontal, 18)
                            .padding(.vertical, 11)
                            .background(selectedIndex == index ? Color(hex: "#2196F3") : Color(hex: "#F4F6FB"))
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.bottom, 4)
        }
    }
}
