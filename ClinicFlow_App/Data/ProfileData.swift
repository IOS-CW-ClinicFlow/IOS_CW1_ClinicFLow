//
//  ProfileData.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-10.
//
import SwiftUI

struct ProfileData {

    static let userName   = "Sandun Dias"
    static let avatarName = "userProfile"   

    static let menuItems: [ProfileMenuItem] = [
        ProfileMenuItem(label: "Your profile",      icon: "person"),
        ProfileMenuItem(label: "Payment Methods",   icon: "creditcard"),
        ProfileMenuItem(label: "Favourite",         icon: "heart"),
        ProfileMenuItem(label: "Settings",          icon: "gearshape"),
        ProfileMenuItem(label: "Help Center",       icon: "questionmark.circle"),
        ProfileMenuItem(label: "Privacy Policy",    icon: "lock"),
        ProfileMenuItem(label: "Log out",           icon: "rectangle.portrait.and.arrow.right", isDestructive: true),
    ]
}
