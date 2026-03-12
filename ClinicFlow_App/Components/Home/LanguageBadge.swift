//
//  LanguageBadge.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct LanguageBadge: View {
    @State private var selectedLanguage: Language = .english

    enum Language: String, CaseIterable {
        case english = "EN"
        case sinhala = "සිං"
        case tamil   = "தமி"

        var fullName: String {
            switch self {
            case .english: return "English"
            case .sinhala: return "සිංහල"
            case .tamil:   return "தமிழ்"
            }
        }
    }

    var body: some View {
        Menu {
            ForEach(Language.allCases, id: \.self) { lang in
                Button {
                    selectedLanguage = lang
                } label: {
                    Label(lang.fullName, systemImage: lang == selectedLanguage ? "checkmark" : "")
                }
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 9)
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(width: 38, height: 38)
                    .overlay(
                        RoundedRectangle(cornerRadius: 9)
                            .stroke(Color(hex: "#555555"), lineWidth: 2)
                    )
                Text(selectedLanguage.rawValue)
                    .font(.system(size: 11, weight: .heavy))
                    .foregroundColor(Color(hex: "#333333"))
            }
        }
        .menuOrder(.fixed)
    }
}

#Preview {
    HStack {
        Spacer()
        LanguageBadge()
        Spacer()
    }
    .padding()
}
