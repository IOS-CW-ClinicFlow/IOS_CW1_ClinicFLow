//
//  CategoryButton.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct CategoryButton: View {
    let category: ServiceCategory
    var action: (() -> Void)? = nil

    var body: some View {
        Button {
            action?()
        } label: {
            VStack(spacing: 9) {
                ZStack {
                    Circle()
                        .fill(HomeTheme.categoryCircleBg)
                        .frame(width: 66, height: 66)
                    Image(systemName: category.systemImage)
                        .font(.system(size: 28))
                        .foregroundColor(HomeTheme.categoryIcon)
                }
                Text(category.rawValue)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color(hex: "#333333"))
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack {
        ForEach(ServiceCategory.allCases, id: \.self) { category in
            CategoryButton(category: category)
        }
    }
    .padding()
}
