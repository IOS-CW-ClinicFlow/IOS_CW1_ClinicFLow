//
//  WorkingHoursRow.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
//
import SwiftUI

struct WorkingHoursRow: View {
    let entry: WorkingHours

    var body: some View {
        HStack {
            Text(entry.day)
                .font(.system(size: 13))
                .foregroundStyle(Color(hex: "#555555"))
            Spacer()
            Text(entry.hours)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color(hex: "#1a1a1a"))
        }
    }
}
