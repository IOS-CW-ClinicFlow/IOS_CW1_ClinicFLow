//
//  FormFieldLabel.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct FormFieldLabel: View {
    let text:     String
    var required: Bool = true

    var body: some View {
        HStack(spacing: 2) {
            Text(text)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color(hex: "#1a1a1a"))
            if required {
                Text("*")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color(hex: "#F44336"))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom, 6)
    }
}
