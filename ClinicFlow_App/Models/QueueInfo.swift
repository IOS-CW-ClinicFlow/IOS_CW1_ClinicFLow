//
//  QueueInfo.swift
//  ClinicFlow_App
//
//  Created by cobsccomp24.2p-021 on 2026-03-10.
//
import Foundation

struct QueueInfo {
    var current:    Int     // currently being served
    let yourNumber: Int     // patient's queue number
    let waitMin:    Int     // estimated wait in minutes
}
