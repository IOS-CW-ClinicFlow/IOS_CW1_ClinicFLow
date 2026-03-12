//
//  PrescriptionUploadBox.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP242P-051 on 2026-03-11.
//
import SwiftUI

struct PrescriptionUploadBox: View {
    @Binding var hasFile: Bool
    var onUpload: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // Uploaded file thumbnail (shown after upload)
            if hasFile {
                HStack(spacing: 10) {
                    ZStack(alignment: .topTrailing) {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(hex: "#FAFAFE"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(Color(hex: "#E0E0EE"), lineWidth: 1.5)
                            )
                            .frame(width: 58, height: 64)

                        VStack(spacing: 4) {
                            Image(systemName: "doc.text")
                                .font(.system(size: 22))
                                .foregroundStyle(Color(hex: "#BBBBCC"))
                            Text("Doc...")
                                .font(.system(size: 9, weight: .medium))
                                .foregroundStyle(Color(hex: "#BBBBCC"))
                        }
                        .frame(width: 58, height: 64)

                        // Badge
                        ZStack {
                            Circle()
                                .fill(Color(hex: "#E8E8F0"))
                                .frame(width: 18, height: 18)
                            Image(systemName: "xmark")
                                .font(.system(size: 8, weight: .bold))
                                .foregroundStyle(Color(hex: "#888888"))
                        }
                        .offset(x: 7, y: -7)
                        .onTapGesture { hasFile = false }
                    }
                }
                .padding(.bottom, 14)
            }

            // Drop zone
            VStack(spacing: 10) {
                Image(systemName: "icloud.and.arrow.up")
                    .font(.system(size: 36))
                    .foregroundStyle(Color(hex: "#BBBBCC"))

                Text("Upload the prescription given\nby the doctor here")
                    .font(.system(size: 12))
                    .foregroundStyle(Color(hex: "#AAAAAA"))
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)

                Button(action: { hasFile = true; onUpload() }) {
                    Text("Upload")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 13)
                        .background(Color(hex: "#1A8FD1"))
                        .clipShape(Capsule())
                        .shadow(color: Color(hex: "#1A8FD1").opacity(0.32),
                                radius: 12, x: 0, y: 4)
                }
                .buttonStyle(.plain)
                .padding(.top, 4)
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 24)
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color(hex: "#DDDDE8"), lineWidth: 1.5)
            )
        }
    }
}
