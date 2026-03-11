//
//  DayPicker.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct DayPicker: View {
    let days: [DaySlot]
    @Binding var selected: DaySlot

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(days) { slot in
                    let isSelected = slot == selected

                    Button {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            selected = slot
                        }
                    } label: {
                        VStack(spacing: 2) {
                            Text(slot.day)
                                .font(.system(size: 10, weight: .semibold))
                            Text(slot.date)
                                .font(.system(size: 12, weight: .bold))
                        }
                        .foregroundStyle(isSelected ? .white : Color(hex: "#555555"))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(isSelected ? Color(hex: "#2196F3") : Color(hex: "#F4F6FB"))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.bottom, 4)
        }
    }
}
