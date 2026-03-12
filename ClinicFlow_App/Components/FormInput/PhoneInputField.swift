//
//  PhoneInputField.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import SwiftUI

struct CFPhoneInputField: View {
    @Binding var text: String
    @FocusState private var focused: Bool
    @State private var selectedCountry = Country.defaultCountry
    @State private var showCountryPicker = false
    var error: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 0) {
                
                // ── Flag + chevron (tap to change country) ─────────────────────
                Button {
                    showCountryPicker = true
                } label: {
                    HStack(spacing: 4) {
                        Text(selectedCountry.flag)
                            .font(.system(size: 18))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(Color(hex: "#8e8e93"))
                    }
                    .padding(.leading, 14)
                    .padding(.trailing, 8)
                }
                .buttonStyle(.plain)
                
                // ── Thin separator ─────────────────────────────────────────────
                Rectangle()
                    .fill(focused ? Color.cfBlue : Color.cfBorder)
                    .frame(width: 1, height: 22)
                
                // ── Dial code (static, non-editable) ──────────────────────────
                Text("+\(selectedCountry.dialCode)")
                    .font(.cfDisplay(size: 15))
                    .foregroundColor(.cfText)
                    .padding(.leading, 10)
                
                // ── Number input (user types digits here only) ─────────────────
                TextField("Phone number", text: $text)
                    .font(.cfDisplay(size: 15))
                    .foregroundColor(.cfText)
                    .keyboardType(.numberPad)
                    .focused($focused)
                    .padding(.leading, 6)
                    .padding(.trailing, 14)
                    .onChange(of: text) { newValue in
                        // Strip everything that isn't a digit
                        let digitsOnly = newValue.filter(\.isNumber)
                        // Cap to this country's max digit count
                        let capped = String(digitsOnly.prefix(selectedCountry.maxDigits))
                        if text != capped { text = capped }
                    }
            }
            .frame(height: 52)
            .background(Color(hex: "#fafafa"))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        error != nil ? Color.cfError : (focused ? Color.cfBlue : Color.cfBorder),
                        lineWidth: 1.5
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .animation(.easeInOut(duration: 0.2), value: focused)
            .sheet(isPresented: $showCountryPicker) {
                CountryPickerSheet(selected: $selectedCountry)
            }
            .onChange(of: selectedCountry) { _ in
                // Clear number when country changes so user re-enters cleanly
                text = ""
            }
            
            if let error = error {
                Text(error)
                    .font(.cfDisplay(size: 11))
                    .foregroundColor(.cfError)
                    .padding(.leading, 16) // align under input area
            }
        }
        
        /// Full E.164-style number e.g. "+94760012345" — use this when submitting.
        var fullNumber: String {
            "+\(selectedCountry.dialCode)\(text.filter(\.isNumber))"
        }
    }
    
    // ─── Country Picker Sheet ─────────────────────────────────────────────────────
    
    private struct CountryPickerSheet: View {
        @Binding var selected: Country
        @Environment(\.dismiss) private var dismiss
        @State private var searchText = ""
        
        var filtered: [Country] {
            searchText.isEmpty
            ? Country.all
            : Country.all.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.dialCode.contains(searchText)
            }
        }
        
        var body: some View {
            NavigationStack {
                List(filtered) { country in
                    Button {
                        selected = country
                        dismiss()
                    } label: {
                        HStack(spacing: 12) {
                            Text(country.flag)
                                .font(.system(size: 22))
                            Text(country.name)
                                .font(.cfDisplay(size: 15))
                                .foregroundColor(.cfText)
                            Spacer()
                            Text("+\(country.dialCode)")
                                .font(.cfDisplay(size: 14))
                                .foregroundColor(.cfSubtext)
                        }
                        .padding(.vertical, 4)
                    }
                    .listRowBackground(
                        selected == country ? Color(hex: "#eaf5fe") : Color.white
                    )
                }
                .listStyle(.plain)
                .searchable(text: $searchText, prompt: "Search country…")
                .navigationTitle("Select Country")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") { dismiss() }
                            .foregroundColor(.cfBlue)
                    }
                }
            }
        }
    }
    
}
