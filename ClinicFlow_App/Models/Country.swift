//
//  Country.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import Foundation

struct Country: Identifiable, Equatable, Hashable {
    let id = UUID()
    let name: String
    let dialCode: String
    let flag: String
    var maxDigits: Int = 15              // default maximum for phone number digits

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: Country, rhs: Country) -> Bool { lhs.id == rhs.id }

    static let defaultCountry = Country(name: "Sri Lanka", dialCode: "94", flag: "🇱🇰", maxDigits: 9)
    static let all: [Country] = [
        defaultCountry,
        Country(name: "United States",   dialCode: "1",   flag: "🇺🇸", maxDigits: 10),
        Country(name: "United Kingdom",  dialCode: "44",  flag: "🇬🇧", maxDigits: 10),
        Country(name: "Australia",       dialCode: "61",  flag: "🇦🇺", maxDigits: 9),
        Country(name: "India",           dialCode: "91",  flag: "🇮🇳", maxDigits: 10),
        Country(name: "Canada",          dialCode: "1",   flag: "🇨🇦", maxDigits: 10),
        Country(name: "Germany",         dialCode: "49",  flag: "🇩🇪", maxDigits: 11),
        Country(name: "France",          dialCode: "33",  flag: "🇫🇷", maxDigits: 9),
        Country(name: "Japan",           dialCode: "81",  flag: "🇯🇵", maxDigits: 10),
        Country(name: "Singapore",       dialCode: "65",  flag: "🇸🇬", maxDigits: 8),
        Country(name: "UAE",             dialCode: "971", flag: "🇦🇪", maxDigits: 9),
    ]
}
