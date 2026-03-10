//
//  CallScreen.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

// ── Call state machine ────────────────────────────────────────────────────────

private enum CallState {
    case calling
    case connected
    case ended
}

// ── Animated pulse ring ───────────────────────────────────────────────────────

private struct PulseRing: View {
    let delay: Double
    let color: Color
    @State private var animating = false

    var body: some View {
        Circle()
            .stroke(color.opacity(0.35), lineWidth: 2)
            .scaleEffect(animating ? 2.4 : 1.0)
            .opacity(animating ? 0 : 1)
            .animation(
                .easeOut(duration: 2.0)
                .repeatForever(autoreverses: false)
                .delay(delay),
                value: animating
            )
            .onAppear { animating = true }
    }
}

// ── Soft action button ────────────────────────────────────────────────────────

private struct CallActionButton: View {
    let icon:       String
    let label:      String
    var isActive:   Bool   = false
    var action:     () -> Void = {}

    var body: some View {
        VStack(spacing: 8) {
            Button { action() } label: {
                ZStack {
                    Circle()
                        .fill(isActive
                              ? Color.white
                              : Color.white.opacity(0.2))
                        .frame(width: 60, height: 60)
                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(isActive ? Color(hex: "#0D6E5A") : .white)
                }
            }
            .buttonStyle(.plain)

            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white.opacity(0.75))
        }
    }
}

// ── Screen ────────────────────────────────────────────────────────────────────

struct CallScreen: View {

    var onEnd: () -> Void = {}

    @State private var callState:    CallState = .calling
    @State private var isMuted:      Bool      = false
    @State private var isSpeaker:    Bool      = false
    @State private var callDuration: Int       = 0
    @State private var timer:        Timer?    = nil
    @State private var connectTimer: Timer?    = nil

    private var statusText: String {
        switch callState {
        case .calling:   return "Calling..."
        case .connected: return formattedDuration
        case .ended:     return "Call Ended"
        }
    }

    private var formattedDuration: String {
        let m = callDuration / 60
        let s = callDuration % 60
        return String(format: "%02d:%02d", m, s)
    }

    var body: some View {
        ZStack {

            // ── Background — teal blue-green gradient ─────────────────────
            LinearGradient(
                colors: [
                    Color(hex: "#0ABFBC"),
                    Color(hex: "#1A8B6F"),
                    Color(hex: "#0D6E5A")
                ],
                startPoint: .topLeading,
                endPoint:   .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Top bar ────────────────────────────────────────────────
            
                Spacer()

                // ── Avatar + pulse ─────────────────────────────────────────
                ZStack {
                    if callState == .calling {
                        PulseRing(delay: 0.0, color: .white)
                            .frame(width: 110, height: 110)
                        PulseRing(delay: 0.7, color: .white)
                            .frame(width: 110, height: 110)
                        PulseRing(delay: 1.4, color: .white)
                            .frame(width: 110, height: 110)
                    }

        Circle()
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 110, height: 110)
                        .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 8)

                    Image(systemName: "cross.fill")
                        .font(.system(size: 42, weight: .medium))
                        .foregroundStyle(.white)
                }
                .padding(.bottom, 28)

                // ── Caller name + number ───────────────────────────────────
                Text("ClinicFlow Admin")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(.white)

                Text("+94 11 234 5678")
                    .font(.system(size: 15))
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.top, 6)

                // ── Status / timer ─────────────────────────────────────────
                Text(statusText)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.white.opacity(0.85))
                    .padding(.top, 10)
                    .contentTransition(.numericText())
                    .animation(.easeInOut, value: statusText)

                Spacer()

                // ── Mute + Speaker (connected only) ────────────────────────
                if callState == .connected {
                    HStack(spacing: 48) {
                        CallActionButton(
                            icon:     isMuted ? "mic.slash.fill" : "mic.fill",
                            label:    isMuted ? "Unmute" : "Mute",
                            isActive: isMuted
                        ) {
                            withAnimation(.easeInOut(duration: 0.15)) { isMuted.toggle() }
                        }

                        CallActionButton(
                            icon:     "speaker.wave.3.fill",
                            label:    "Speaker",
                            isActive: isSpeaker
                        ) {
                            withAnimation(.easeInOut(duration: 0.15)) { isSpeaker.toggle() }
                        }
                    }
                    .padding(.bottom, 40)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                }

                // ── End call ───────────────────────────────────────────────
                if callState != .ended {
                    Button { endCall() } label: {
                        ZStack {
                            Circle()
                                .fill(Color(hex: "#FF3B30"))
                                .frame(width: 72, height: 72)
                                .shadow(color: Color(hex: "#FF3B30").opacity(0.4),
                                        radius: 18, x: 0, y: 6)
                            Image(systemName: "phone.down.fill")
                                .font(.system(size: 26, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 56)
                } else {
                    // Auto-dismissing — show a subtle indicator
                    Text("Call Ended")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(.white.opacity(0.6))
                        .padding(.bottom, 56)
                        .transition(.opacity)
                }
            }
        }
        .onAppear { simulateConnect() }
        .onDisappear { stopTimers() }
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: callState)
    }

    // ── Timer logic ────────────────────────────────────────────────────────

    private func simulateConnect() {
        connectTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            withAnimation { callState = .connected }
            startDurationTimer()
        }
    }

    private func startDurationTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            callDuration += 1
        }
    }

    private func endCall() {
        stopTimers()
        withAnimation { callState = .ended }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { onEnd() }
    }

    private func stopTimers() {
        timer?.invalidate();        timer = nil
        connectTimer?.invalidate(); connectTimer = nil
    }
}

#Preview {
    CallScreen()
}
