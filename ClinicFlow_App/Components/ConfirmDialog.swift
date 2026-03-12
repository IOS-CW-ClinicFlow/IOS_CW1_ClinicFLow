//
//  ConfirmDialog.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-10.
//
import SwiftUI

struct ConfirmDialog: ViewModifier {
    let title: String
    let message: String
    let confirmLabel: String
    @Binding var isPresented: Bool
    var onConfirm: () -> Void

    func body(content: Content) -> some View {
        content
            .confirmationDialog(title, isPresented: $isPresented, titleVisibility: .visible) {
                Button(confirmLabel, role: .destructive) { onConfirm() }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text(message)
            }
    }
}

extension View {
    func confirmDialog(
        title: String,
        message: String,
        confirmLabel: String,
        isPresented: Binding<Bool>,
        onConfirm: @escaping () -> Void
    ) -> some View {
        modifier(ConfirmDialog(
            title:        title,
            message:      message,
            confirmLabel: confirmLabel,
            isPresented:  isPresented,
            onConfirm:    onConfirm
        ))
    }
}
