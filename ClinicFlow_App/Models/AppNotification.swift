//
//  AppNotification.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-09.
//
import Foundation

struct AppNotification: Identifiable {
    let id = UUID()
    let date: String
    let time: String
    let message: String
    let ago: String
}
