//
//  ProfileMenuItem.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-10.
//
import SwiftUI

struct ProfileMenuItem: Identifiable {
    let id = UUID()
    let label: String
    let icon: String        // SF Symbol name
    var isDestructive: Bool = false
}
