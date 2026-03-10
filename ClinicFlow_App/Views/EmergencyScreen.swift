//
//  EmergencyScreen.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-10.
//
import SwiftUI

struct EmergencyScreen: View {

    var onBack:   () -> Void = {}
    var onCall:   (EmergencyActionType) -> Void = { _ in }

    @State private var showWheelchair = false
    @State private var pulseAlert     = false

    var body: some View {
        VStack(spacing: 0) {

            // ── Top bar ────────────────────────────────────────────────────
            TopBar(title: "Emergency", showBack: true, onBack: onBack)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {

                    // ── SOS banner ─────────────────────────────────────────
                    ZStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [Color(hex: "#FF3B30"), Color(hex: "#C0392B")],
                                    startPoint: .topLeading,
                                    endPoint:   .bottomTrailing
                                )
                            )
                            .shadow(color: Color(hex: "#FF3B30").opacity(0.35),
                                    radius: 16, x: 0, y: 6)

                        // Pulse ring behind icon
                        Circle()
                            .stroke(Color.white.opacity(0.25), lineWidth: 2)
                            .frame(width: pulseAlert ? 90 : 64, height: pulseAlert ? 90 : 64)
                            .opacity(pulseAlert ? 0 : 0.6)
                            .animation(
                                .easeOut(duration: 1.6).repeatForever(autoreverses: false),
                                value: pulseAlert
                            )

                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(width: 56, height: 56)
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Emergency Assistance")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.white)
                                Text("Select the help you need below.\nStaff are available 24/7.")
                                    .font(.system(size: 12))
                                    .foregroundStyle(.white.opacity(0.85))
                            }
                            Spacer()
                        }
                        .padding(20)
                    }

                    // ── Action cards ───────────────────────────────────────
                    VStack(spacing: 12) {
                        ForEach(EmergencyData.actions) { actionType in
                            EmergencyActionCard(action: actionType) {
                                handleTap(actionType)
                            }
                        }
                    }

                    // ── Reassurance footer ─────────────────────────────────
                    HStack(spacing: 6) {
                        Image(systemName: "shield.checkered")
                            .font(.system(size: 13))
                            .foregroundStyle(Color(hex: "#2ECC88"))
                        Text("ClinicFlow staff are available 24 hours, 7 days a week")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(hex: "#888888"))
                    }
                    .padding(.vertical, 8)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
            }
            .background(Color(hex: "#F4F8FF"))
        }
        .background(Color(hex: "#F4F8FF"))
        .onAppear { pulseAlert = true }

        // ── Wheelchair sheet ───────────────────────────────────────────────
        .sheet(isPresented: $showWheelchair) {
            WheelchairConfirmSheet(
                onConfirm: {},
                onDismiss: { showWheelchair = false }
            )
            .presentationDetents([.height(460)])
            .presentationDragIndicator(.hidden)
        }
    }

    // ── Action routing ─────────────────────────────────────────────────────

    private func handleTap(_ action: EmergencyActionType) {
        switch action {
        case .wheelchair:
            showWheelchair = true
        case .callHelp, .ambulance:
            onCall(action)
        }
    }
}

#Preview {
    EmergencyScreen()
}
