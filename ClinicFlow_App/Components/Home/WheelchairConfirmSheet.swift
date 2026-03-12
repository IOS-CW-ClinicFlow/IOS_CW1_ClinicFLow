//
//  WheelchairConfirmSheet.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-10.
//
import SwiftUI

struct WheelchairConfirmSheet: View {

    var onConfirm:  () -> Void = {}
    var onDismiss:  () -> Void = {}

    @State private var sent = false

    var body: some View {
        VStack(spacing: 0) {

            // Handle
            Capsule()
                .fill(Color(hex: "#DDDDDD"))
                .frame(width: 36, height: 4)
                .padding(.top, 10)
                .padding(.bottom, 24)

            if sent {
                // Confirmation state
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#1A8FD1").opacity(0.12))
                            .frame(width: 80, height: 80)
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(Color(hex: "#1A8FD1"))
                    }

                    Text("Request Sent!")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))

                    Text("A wheelchair is on its way.\nPlease wait at your current location.")
                        .font(.system(size: 14))
                        .foregroundStyle(Color(hex: "#666666"))
                        .multilineTextAlignment(.center)

                    Button { onDismiss() } label: {
                        Text("Done")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color(hex: "#1A8FD1"))
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                }
                .padding(.bottom, 40)
                .transition(.opacity.combined(with: .scale(scale: 0.95)))

            } else {
                // Request state
                VStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "#1A8FD1").opacity(0.10))
                            .frame(width: 80, height: 80)
                        Image(systemName: "figure.roll")
                            .font(.system(size: 38))
                            .foregroundStyle(Color(hex: "#1A8FD1"))
                    }

                    Text("Wheelchair Assistance")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(Color(hex: "#1a1a1a"))

                    Text("A staff member will bring a wheelchair to your current location. Confirm to send the request.")
                        .font(.system(size: 13))
                        .foregroundStyle(Color(hex: "#666666"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 8)

                    VStack(spacing: 10) {
                        Button {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.75)) {
                                sent = true
                                onConfirm()
                            }
                        } label: {
                            Text("Confirm Request")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .background(Color(hex: "#1A8FD1"))
                                .clipShape(Capsule())
                                .shadow(color: Color(hex: "#1A8FD1").opacity(0.35),
                                        radius: 12, x: 0, y: 4)
                        }
                        .buttonStyle(.plain)

                        Button { onDismiss() } label: {
                            Text("Cancel")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundStyle(Color(hex: "#888888"))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                }
                .padding(.bottom, 40)
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: sent)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}
