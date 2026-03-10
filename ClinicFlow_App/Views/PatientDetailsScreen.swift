//
//  PatientDetailsScreen.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import SwiftUI

struct PatientDetailsScreen: View {

    var initialBookingFor: BookingFor = .self
    var onBack: () -> Void = {}
    var onNext: (PatientForm) -> Void = { _ in }

    @State private var form: PatientForm
    @State private var errors = PatientFormErrors()
    @State private var didAttemptSubmit = false

    init(
        initialBookingFor: BookingFor = .self,
        onBack: @escaping () -> Void = {},
        onNext: @escaping (PatientForm) -> Void = { _ in }
    ) {
        self.initialBookingFor = initialBookingFor
        self.onBack = onBack
        self.onNext = onNext
        _form = State(initialValue: PatientDetailsData.defaultForm(for: initialBookingFor))
    }

    private var isSelf: Bool { form.bookingFor == .self }

    // Re-validate live once user has attempted submit once
    private func liveValidate() {
        guard didAttemptSubmit else { return }
        errors = PatientFormValidator.validate(form)
    }

    var body: some View {
        VStack(spacing: 0) {

            // ── Top bar ────────────────────────────────────────────────────
            TopBar(title: "Patient Details", showBack: true, onBack: onBack)

            // ── Scrollable form ────────────────────────────────────────────
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // Booking for — segmented control, clearer than a dropdown
                    FormFieldLabel(text: "Booking for")
                    Picker("Booking for", selection: Binding(
                        get: { form.bookingFor },
                        set: { newVal in
                            withAnimation(.easeInOut(duration: 0.2)) {
                                form = PatientDetailsData.defaultForm(for: newVal)
                                errors = PatientFormErrors()
                                didAttemptSubmit = false
                            }
                        }
                    )) {
                        ForEach(BookingFor.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom, 16)

                    // Full Name
                    FormFieldLabel(text: "Full Name")
                    FormTextField(
                        placeholder:  "Enter full name",
                        text:         $form.fullName,
                        errorMessage: errors.fullName
                    )
                    .onChange(of: form.fullName) { _ in liveValidate() }

                    // Relationship — only for Someone else
                    if !isSelf {
                        FormFieldLabel(text: "Relationship")
                        FormPickerField(
                            options:   Relationship.allCases,
                            label:     { $0.rawValue },
                            selection: $form.relationship
                        )
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }

                    // Mobile
                    FormFieldLabel(text: "Mobile Number")
                    FormTextField(
                        placeholder:  "+94 XX XXX XXXX",
                        text:         $form.mobile,
                        errorMessage: errors.mobile,
                        keyboardType: .phonePad
                    )
                    .onChange(of: form.mobile) { _ in liveValidate() }

                    // Gender
                    FormFieldLabel(text: "Gender")
                    FormPickerField(
                        options:   Gender.allCases,
                        label:     { $0.rawValue },
                        selection: $form.gender
                    )

                    // Age
                    FormFieldLabel(text: isSelf ? "Your Age" : "Age")
                    FormTextField(
                        placeholder:  "e.g. 34",
                        text:         $form.age,
                        errorMessage: errors.age,
                        keyboardType: .numberPad
                    )
                    .onChange(of: form.age) { _ in liveValidate() }

                    // Problem
                    FormFieldLabel(text: "Write Your Problem", required: false)
                    FormTextArea(
                        placeholder:  "Write here...",
                        text:         $form.problem,
                        errorMessage: errors.problem
                    )
                    .onChange(of: form.problem) { _ in liveValidate() }

                    Spacer(minLength: 16)
                }
                .padding(.horizontal, 20)
                .padding(.top, 22)
                .animation(.easeInOut(duration: 0.2), value: isSelf)
            }
            .background(Color.white)

            // ── Next CTA ───────────────────────────────────────────────────
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color(hex: "#F2F2F7"))
                    .frame(height: 1)

                Button {
                    didAttemptSubmit = true
                    let result = PatientFormValidator.validate(form)
                    withAnimation(.easeInOut(duration: 0.2)) {
                        errors = result
                    }
                    if !result.hasErrors {
                        onNext(form)
                    }
                } label: {
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
    PatientDetailsScreen()
}
