//
//  SectionHeader.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct SectionHeader: View {
    let title: String
    var onSeeAll: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: HomeTheme.sectionTitleSize,
                              weight: HomeTheme.sectionTitleWeight))
                .foregroundColor(.cfText)
                .kerning(-0.3)
            Spacer()
            if let onSeeAll {
                Button("See All", action: onSeeAll)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(HomeTheme.seeAllColor)
            }
        }
        .padding(.bottom, 14)
    }
}

#Preview {
    SectionHeader(title: "Today's Doctors", onSeeAll: {})
        .padding()
}
