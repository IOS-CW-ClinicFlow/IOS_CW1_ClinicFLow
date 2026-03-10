//
//  SelectPackageScreen.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct SelectPackageScreen: View {

    var onBack: () -> Void = {}
    var onNext: (ConsultationPackage) -> Void = { _ in }

    @State private var selected: ConsultationPackage = SelectPackageData.packages.last!

    var body: some View {
        VStack(spacing: 0) {

            // ── Top bar ────────────────────────────────────────────────────
            TopBar(title: "Select Package", showBack: true, onBack: onBack)

            // ── Scrollable body ────────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    Text("Select Package")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))
                        .padding(.bottom, 20)

                    // Package list
                    VStack(spacing: 14) {
                        ForEach(SelectPackageData.packages) { pkg in
                            PackageRow(
                                package_:   pkg,
                                isSelected: selected == pkg,
                                onTap: {
                                    withAnimation(.easeInOut(duration: 0.15)) {
                                        selected = pkg
                                    }
                                }
                            )
                        }
                    }

                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
            }
            .background(Color.white)

            // ── Next CTA ───────────────────────────────────────────────────
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(height: 1)

                Button { onNext(selected) } label: {
                    Text("Next")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color(hex: "#2196F3"))
                        .clipShape(Capsule())
                        .shadow(color: Color(hex: "#2196F3").opacity(0.4), radius: 16, x: 0, y: 4)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
            .background(Color.white)
        }
        .background(Color.white)
    }
}

#Preview {
    SelectPackageScreen()
}
