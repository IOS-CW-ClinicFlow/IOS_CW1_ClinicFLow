//
//  ServicePlace.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import Foundation

// Shared by both Lab and Pharmacy cards (both use the ImageCard layout)
struct ServicePlace: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let location: String
    let hours: String
    let isOpen: Bool
    let imageName: String
    let slug: String
}
