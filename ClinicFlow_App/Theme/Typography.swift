//
//  Typography.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//

import SwiftUI

extension Font {

    // ── Display ────────────────────────────────────────────────────────────
    /// Large headings — e.g. screen titles.
    static func cfDisplay(size: CGFloat, weight: Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }

    // ── Body ───────────────────────────────────────────────────────────────
    /// Standard body copy.
    static func cfBody(size: CGFloat = 16, weight: Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }

    // ── Caption ────────────────────────────────────────────────────────────
    /// Small labels — e.g. tab bar labels.
    static func cfCaption(size: CGFloat = 10, weight: Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}
