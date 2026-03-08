//
//  ServiceDoctor.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-08.
//
import Foundation

struct ServiceDoctor: Identifiable {
    let id = UUID()
    let name: String
    let specialty: String
    let imageName: String
    let rating: Double
    let filledStars: Int
    let isFavoured: Bool
    let slug: String
}
