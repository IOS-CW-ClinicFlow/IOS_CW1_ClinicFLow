//
//  FormPickerField.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct FormPickerField<T: Hashable>: View {
    let options:      [T]
    let label:        (T) -> String
    @Binding var selection: T
    var errorMessage: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(label(option)) { selection = option }
                }
            } label: {
                HStack {
                    Text(label(selection))
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                    Spacer()
                    Image(systemName: "chevron.down")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color(hex: "#2196F3"))
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 13)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            errorMessage != nil ? Color(hex: "#F44336") : Color(hex: "#E0E0EE"),
                            lineWidth: 1.5
                        )
                )
            }

            if let error = errorMessage {
                HStack(spacing: 4) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 11))
                    Text(error)
                        .font(.system(size: 11, weight: .medium))
                }
                .foregroundStyle(Color(hex: "#F44336"))
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.bottom, 16)
        .animation(.easeInOut(duration: 0.2), value: errorMessage)
    }
}
