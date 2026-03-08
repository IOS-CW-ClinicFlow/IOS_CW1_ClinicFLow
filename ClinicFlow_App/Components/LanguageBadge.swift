//
//  LanguageBadge.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct LanguageBadge: View {
    @State private var selectedLanguage: Language = .english
    @State private var showDropdown = false

    enum Language: String, CaseIterable {
        case english  = "EN"
        case sinhala  = "සිං"   // සිංහල
        case tamil    = "தமி"   // தமிழ்

        var fullName: String {
            switch self {
            case .english: return "English"
            case .sinhala: return "සිංහල"
            case .tamil:   return "தமிழ்"
            }
        }
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {

            // ── Badge button ───────────────────────────────────────────────
            Button { showDropdown.toggle() } label: {
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
            .buttonStyle(.plain)

            // ── Dropdown menu ──────────────────────────────────────────────
            if showDropdown {
                VStack(spacing: 0) {
                    ForEach(Language.allCases, id: \.self) { lang in
                        Button {
                            selectedLanguage = lang
                            showDropdown = false
                        } label: {
                            HStack(spacing: 10) {
                                Text(lang.rawValue)
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(Color(hex: "#333333"))
                                    .frame(width: 28)
                                Text(lang.fullName)
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(hex: "#333333"))
                                Spacer()
                                if lang == selectedLanguage {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 11, weight: .semibold))
                                        .foregroundColor(Color(hex: "#2a9df4"))
                                }
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 11)
                            .background(lang == selectedLanguage
                                ? Color(hex: "#EAF4FE")
                                : Color.white)
                        }
                        .buttonStyle(.plain)

                        if lang != Language.allCases.last {
                            Divider()
                        }
                    }
                }
                .frame(width: 160)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black.opacity(0.14), radius: 16, x: 0, y: 6)
                .offset(x: -120, y: 44)   // drops below badge, aligned right
                .zIndex(99)
            }
        }
        // Dismiss when tapping outside
        .onTapGesture { }
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
