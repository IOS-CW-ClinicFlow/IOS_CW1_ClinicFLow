//
//  TimePicker.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct TimePicker: View {
    let times: [TimeSlot]
    @Binding var selected: TimeSlot

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(times) { slot in
                    let isSelected = slot == selected

                    Button {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            selected = slot
                        }
                    } label: {
                        Text(slot.time)
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(isSelected ? .white : Color(hex: "#555555"))
                            .padding(.horizontal, 18)
                            .padding(.vertical, 11)
                            .background(isSelected ? Color(hex: "#2196F3") : Color(hex: "#F4F6FB"))
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.bottom, 4)
        }
    }
}
