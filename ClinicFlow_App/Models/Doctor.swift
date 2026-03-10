//
//  Doctor.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import Foundation

struct Doctor: Identifiable {
    let id = UUID()
    let name: String
    let credentials: String
    let rating: Double
    let imageName: String           // Asset name in Assets.xcassets
    let backgroundColorHex: String
    let slug: String
}
