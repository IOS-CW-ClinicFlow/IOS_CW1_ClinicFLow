//
//  Lab.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import Foundation

struct Lab: Identifiable {
    let id = UUID()
    let name: String
    let waitTime: String        // e.g. "15 min"
    let distance: String        // e.g. "1.5km"
    let rating: Double
    let imageName: String       // Asset name in Assets.xcassets
    let slug: String  
}
