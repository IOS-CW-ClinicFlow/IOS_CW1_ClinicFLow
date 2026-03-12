//
//  MapWayPoints.swift
//  ClinicFlow_App
//
//  Created by COBSCCOMP24.2P-019 on 2026-03-12.
//

import Foundation

// ── Node ─────────────────────────────────────────────────────────────────────

struct WaypointNode: Identifiable, Hashable {
    let id: String          // unique key
    let x: Double           // ratio 0-1
    let y: Double           // ratio 0-1

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (a: WaypointNode, b: WaypointNode) -> Bool { a.id == b.id }
}

// ── Graph ─────────────────────────────────────────────────────────────────────

struct WaypointGraph {

    // All corridor junction nodes
    // Naming: L=left corridor, C=centre, R=right corridor, rows 1-7 top to bottom
    static let nodes: [String: WaypointNode] = {
        let raw: [(String, Double, Double)] = [
            // Left corridor junctions
            ("L1", 0.30, 0.13),
            ("L2", 0.30, 0.28),
            ("L3", 0.30, 0.41),
            ("L4", 0.30, 0.55),
            ("L5", 0.30, 0.68),
            ("L6", 0.30, 0.80),
            ("L7", 0.30, 0.91),

            // Centre corridor junctions
            ("C1", 0.50, 0.11),
            ("C2", 0.50, 0.28),
            ("C3", 0.50, 0.41),
            ("C4", 0.50, 0.52),   // "You are here" / Waiting Hall
            ("C5", 0.50, 0.55),
            ("C6", 0.50, 0.68),
            ("C7", 0.50, 0.80),
            ("C8", 0.50, 0.91),

            // Right corridor junctions
            ("R1", 0.70, 0.13),
            ("R2", 0.70, 0.28),
            ("R3", 0.70, 0.41),
            ("R4", 0.70, 0.55),
            ("R5", 0.70, 0.68),
            ("R6", 0.70, 0.80),
            ("R7", 0.70, 0.91),
        ]
        var dict: [String: WaypointNode] = [:]
        for (id, x, y) in raw { dict[id] = WaypointNode(id: id, x: x, y: y) }
        return dict
    }()

    // Adjacency list — only corridor edges (horizontal + vertical, no diagonals)
    static let edges: [String: [String]] = [
        // Left vertical corridor
        "L1": ["L2", "C1"],
        "L2": ["L1", "L3", "C2"],
        "L3": ["L2", "L4", "C3"],
        "L4": ["L3", "L5", "C5"],
        "L5": ["L4", "L6", "C6"],
        "L6": ["L5", "L7", "C7"],
        "L7": ["L6", "C8"],

        // Centre vertical corridor
        "C1": ["C2", "L1", "R1"],
        "C2": ["C1", "C3", "L2", "R2"],
        "C3": ["C2", "C4", "L3", "R3"],
        "C4": ["C3", "C5"],           // Waiting Hall — connects up/down only
        "C5": ["C4", "C6", "L4", "R4"],
        "C6": ["C5", "C7", "L5", "R5"],
        "C7": ["C6", "C8", "L6", "R6"],
        "C8": ["C7", "L7", "R7"],

        // Right vertical corridor
        "R1": ["R2", "C1"],
        "R2": ["R1", "R3", "C2"],
        "R3": ["R2", "R4", "C3"],
        "R4": ["R3", "R5", "C5"],
        "R5": ["R4", "R6", "C6"],
        "R6": ["R5", "R7", "C7"],
        "R7": ["R6", "C8"],
    ]

    // Nearest corridor node for each room (pin label → node id)
    static let roomToNode: [String: String] = [
        "Reception":        "L1",
        "Registration":     "C1",
        "Laboratory":       "R1",
        "Sharing Room":     "L2",
        "Special Ward-1":   "R2",
        "Doctor Room":      "L3",
        "Waiting Hall":     "C4",
        "X-Ray Room":       "R3",
        "Consultation Room":"L4",
        "Special Ward-2":   "R4",
        "Emergency Room":   "L5",
        "ICU":              "R5",
        "Nurse Station":    "L6",
        "Pharmacy":         "C7",
        "CT Scan":          "R6",
        "Washrooms":        "L7",
        "Payment":          "R7",
    ]

    // ── A* pathfinder ─────────────────────────────────────────────────────

    static func path(from startLabel: String, to endLabel: String) -> [WaypointNode] {
        guard
            let startId = roomToNode[startLabel],
            let endId   = roomToNode[endLabel],
            let start   = nodes[startId],
            let goal    = nodes[endId]
        else { return [] }

        if startId == endId { return [start] }

        struct State: Comparable {
            let node: String
            let g: Double
            let f: Double
            let path: [String]
            static func < (a: State, b: State) -> Bool { a.f < b.f }
        }

        func h(_ id: String) -> Double {
            guard let n = nodes[id] else { return 0 }
            return abs(n.x - goal.x) + abs(n.y - goal.y)
        }

        var open  = [State(node: startId, g: 0, f: h(startId), path: [startId])]
        var visited = Set<String>()

        while !open.isEmpty {
            open.sort()
            let current = open.removeFirst()
            if visited.contains(current.node) { continue }
            visited.insert(current.node)

            if current.node == endId {
                return current.path.compactMap { nodes[$0] }
            }

            for neighbour in edges[current.node] ?? [] {
                guard !visited.contains(neighbour),
                      let cn = nodes[current.node],
                      let nn = nodes[neighbour] else { continue }
                let cost = current.g + abs(cn.x - nn.x) + abs(cn.y - nn.y)
                open.append(State(node: neighbour, g: cost,
                                  f: cost + h(neighbour),
                                  path: current.path + [neighbour]))
            }
        }
        return []
    }
}
